var dashboardApp = new Vue({
  el: '#dashboard',
  data: {
    project: {
      name : '',
      short_description: '',
      start_date : '',
      target_date : '',
      budget : '',
      spent : '',
      projected_spend: '',
      weekly_effort_target: ''
    },
    tasks: [
      {
        id: 0,
        title: '',
        type : '',
        size : '',
        team : '',
        status: '',
        start_date: '',
        close_date: null,
        hours_worked: '',
        perc_complete: '',
        current_sprint : ''
      }
    ],
    filter: {
      showOpenClose: 'all',
      current_sprint_only: false
    }
  },
  computed: {
    days_left: function () {
      return moment(this.project.target_date).diff(moment(), 'days')
    },
    filteredTasks () {
      return this.tasks.filter(t =>
        (this.filter.showOpenClose === 'open' && !t.close_date) ||
        (this.filter.showOpenClose === 'closed' && t.close_date) ||
        this.filter.showOpenClose === 'all'
      )
    }
  },
  methods: {
    pretty_date: function (d) {
      return moment(d).format('l')
    },
    pretty_currency: function (val) {
      if (val < 1e3) {
        return '$ ' + val
      }

      if (val < 1e6) {
        return '$ ' + (val/1e3).toFixed(1) + ' k'
      }

      return '$ ' + (val/1e6).toFixed(1) + ' M'
    },
    completeClass: function(task) {
      if (task.perc_complete == 100 ) {
        return 'alert-success'
      }
      if (task.current_sprint && task.hours_worked == 0 ) {
        return 'alert-warning'
      }
    },
    fetchTasks (pid) {
      fetch('https://raw.githubusercontent.com/tag/iu-msis/dev/app/data/p1-tasks.json' ) //api/tasks.php?projectId='+pid)
      .then( response => response.json() )
      .then( json => {dashboardApp.tasks = json} )
      .catch( err => {
        console.log('TASK FETCH ERROR:');
        console.log(err);
      })
    },
    fetchProject (pid) {
      fetch('https://raw.githubusercontent.com/tag/iu-msis/dev/app/data/project1.json')
      .then( response => response.json() )
      .then( json => {dashboardApp.project = json})
      .catch( err => {
        console.log('PROJECT FETCH ERROR:');
        console.log(err);
      })
    },
    fetchProjectHours (pid) {
      fetch('api/workHours.php?projectId='+pid)
      .then( response => response.json() )
      .then( json => {
        // Clean the data?

        // Update Vue model
        dashboardApp.workHours = json;

        // Now that the data has been returned, we can build a chart with it:
        dashboardApp.buildWorkHoursChart();
      })
      .catch( err => {
        console.log('PROJECT HOURS FETCH ERROR:');
        console.log(err);
      })
    },
    gotoTask (tid) {
      // alert ('Clicked: ' + tid)
      window.location = 'task.html?taskId=' + tid;
    },
    buildWorkHoursChart () {
      console.log('Build chart here');

      /**
        Data currently looks like
        [
          {date: '2018-08-01', 'hours':3},
          {date: '2018-08-02', 'hours':5},
          ...
        ]

        But needs to look like
        [
          [ <JS Date object>, 3],
          [ <JS Date object>, 5],
          ...
        ]
      **/
      this.workHours.forEach( (entry, index, arr) => {
        entry.hours = Number(entry.hours);
        entry.runningTotalHours = entry.hours + (index > 0 ? arr[index-1].runningTotalHours: 0);
      });

      var transformedData = this.workHours.map(
        entry => [Date.parse(entry.date), entry.runningTotalHours] // Have to convert the types!
      );
      console.log(transformedData);

      var myChart = Highcharts.chart('chartEffort', {
        title: {
            text: 'Cumulative Effort'
        },
        xAxis: {
            type: 'datetime'
        },
        yAxis: {
            title: {
                text: 'Hours'
            }
        },
        legend: {
                enabled: false
            },
        series: [{
                type: 'area',
                name: 'Total hours',
                data: transformedData
            }]
    });

    }
  },
  created () {
    const url = new URL(window.location.href);
    this.projectId = url.searchParams.get('projectId');

    if (!this.projectId) {
      console.error('Project Id not found in URL parameter.');
    }

    this.fetchProject(this.projectId);
    this.fetchTasks(this.projectId);
    this.fetchProjectHours(this.projectId);
  }
})
