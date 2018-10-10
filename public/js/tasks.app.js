var tasksApp = new Vue({
  el: '#taskMain',
  data: {
    task: {
      id: 0,
      title: 'foo',
      type : '',
      size : '',
      team : '',
      status: '',
      start_date: '',
      close_date: null,
      hours_worked: '',
      perc_complete: '',
      current_sprint : ''
    },
    work: [ ],
    workForm: { },   // populated by this.getEmptyWorkForm()
    teamList: [] // All the teams
  },
  computed: {
    workSpan () {
      return moment(this.workForm.stop)
             .diff(moment(this.workForm.start), 'hours', true)
             .toFixed(1);
    }
  },
  methods: {
    handleWorkForm(e) {
      e.preventDefault();

      // TODO: Check validity


      console.log(e);

      // TODO: Calculate hours
      // something like:  moment.duration(end.diff(startTime)).asHours();

      //TODO: clone workForm
      const s = JSON.stringify(this.workForm);
      //TODO: POST to remote server
      //TODO: Append result
      this.work.push(JSON.parse(s));

      // Reset workForm
      this.workForm = this.getEmptyWorkForm();
    },
    sumHours() {
      return this.work.reduce( (sum, current) => sum + current.hours, 0 )
    },
    diffAsHours() {
      return 0 //moment().duration(end.diff(startTime)).asHours();
    },
    datetimeFormat(d) {
      d = d || moment();
      return moment(d).format('YYYY-MM-DD[T]HH:MM');
    },
    getEmptyWorkForm() {
      return {
        start: this.datetimeFormat(),
        stop: this.datetimeFormat(),
        teamList: null,
        completion_estimate: 0
      }
    },
    prettyDate(d) {
      return moment(d).format('YYYY-MM-DD HH:MM')
    }
  },
  created () {
    // Populate workForm with default values
    this.workForm = this.getEmptyWorkForm();

    // Do data fetch
    const url = new URL(window.location.href);
    const taskId = url.searchParams.get('taskId');
    console.log('Task: '+ taskId);

    if (!taskId) {
      //TODO: Error? 404?
      //e.g., window.location = '404.html';
    }

    // TODO: Fetch task-specific data
    // fetch('api/task?id=4')
    fetch('api/work.php?taskId='+taskId)
    .then( response => response.json() )
    .then( json => {tasksApp.work = json} )
    .catch( err => {
      console.log('WORK FETCH ERROR:');
      console.log(err);
    })

    fetch('api/team.php')
    .then( response => response.json() )
    .then( json => {tasksApp.teamList = json} )
    .catch( err => {
      console.log('TEAM LIST ERROR:');
      console.log(err);
    })
  }
})
