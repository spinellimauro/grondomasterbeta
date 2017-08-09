var app = angular.module('grondomasterApp', ['ui.router']);

app.controller('buscarController', function(JugadorService) {
    var self = this;
    this.resultados = [];

    this.getResultados = function() {
        JugadorService.getSome(self.query, function(response) {
            self.resultados = _.map(response.data, Jugador.asJugador);
        });
    };

    this.getTransferibles = function() {
        JugadorService.getTransferibles(function(response) {
            self.transferibles = _.map(response.data, Jugador.asJugador);
        });
    };

    self.getTransferibles();
});

app.controller('loginController', function(DTService, $state) {
    
    this.nombre = "";
    this.password = "";
    this.mensaje = "";
    this.iniciarSesion = function(){
        var self = this;
        DTService.nombreDT = this.nombre;
        DTService.password = this.password;
         
        
            DTService.getUsuario(function (response) {
                if(response.data != "null"){
                    DTService.toDT(response.data);
                    $state.go('main.inicio.plantel');
                }else{
                    self.mensaje =  "El usuario y contraseña no coinciden.";
                }
            });    
    };  
  


   /* this.logIn = function() {
        $state.go("main.inicio.plantel");
    }; */
});

app.controller('mainController', function(DTService,JugadorService, TorneoService,$state) {
    var self = this;
    this.DT = DTService.usuarioActivo;
    this.monto = 0;
    this.jugador = DTService.jugadorSeleccionado;
    this.precioTransferible = 0;
// PUTS
    this.venderALaMaquina = function(jugadorID){
        DTService.venderJugadorALaMaquina(this.DT.nombreDT, jugadorID).then(function(){

        });
    };

    this.comprarAOtroDT = function(jugadorID){
        DTService.comprarJugador(this.DT.nombreDT, jugadorID).then(function(){

        });
    };

    
    this.comprarAMaquina = function(jugadorID){
        DTService.comprarALaMaquina(this.DT.nombreDT,JugadorService.nombreJugador,jugadorID).then(function(){

        });
    };


    this.comprarSlot = function(){
        DTService.comprarUnSlot(this.DT.nombreDT).then(function(){

        });

    };

    this.cambiarEquipo = function(equipoID,equipoNombre){
        DTService.cambioDeEquipo(this.DT.nombreDT,equipoID,equipoNombre).then(function(){

        });
    };


    this.ponerTransferible = function(jugadorID){
        DTService.transferible(jugadorID,this.precioTransferible).then(function(){

        });
    };
// Ofertar
    this.realizarOferta = function(){
        DTService.confirmarOferta(this.DT.nombreDT,this.jugador.id,this.monto).then(function(){

        });
    };

    this.ofertar = function(){
        
        $state.go('main.ofertar');
    };


// GETS

    this.getDT = function() {
        DTService.getON(function(response) {
            self.DT = DT.asDT(response.data);
        });
    };

    this.getAll = function() {
        DTService.getAll(function(response) {
            self.DTs = _.map(response.data, DT.asDT);
        });
    };

    this.getEquipos = function() {
        this.selected = null;
        DTService.getEquipos(this.query,function(response) {
            self.equipos = response.data;
        });
    };

    this.getTorneos = function() {
        TorneoService.getAll(function(response) {
            self.torneos = _.map(response.data, Torneo.asTorneo);
        });
    };

    this.getListaOfertas = function() {
        DTService.getOfertas(function(response) {
            self.listaOfertas = _.map(response.data, Oferta.asOferta);
        });
    };

    this.getListaTraspasos = function() {
        DTService.getTraspasos(function(response) {
            self.listaTraspasos = _.map(response.data, Transferencia.asTransferencia);
        });
    };
    
    self.getListaTraspasos();
    self.getListaOfertas();
    self.getTorneos();
    self.getDT();
    self.getAll();
});

app.filter('startFrom', function() {
    return function(input, start) {
        start = +start;
        return input.slice(start);
    };
});

app.controller('listaController', function($scope,DTService) {
    this.page = 0;
    this.limit = 10;
    this.sortReverse = true;
    this.sortType = 'nivel';
    
    this.select = function(jugador){
        this.jugadorSeleccionado = jugador;
        DTService.seleccionarJugador(jugador);
    };

    this.selectPartido = function(partido){
        this.partidoSeleccionado = partido;
    };

    this.setLimit = function(number) {
        this.limit = number;
        this.page = 0;
    };

    this.setSort = function(sortType){
        this.sortType = sortType;
        this.sortReverse = !this.sortReverse;
    };

    this.checkUp = function(sortType){
       return this.sortType == sortType && this.sortReverse;
    };

    this.checkDown = function(sortType){
       return this.sortType == sortType && !this.sortReverse;
    };

    this.next = function() {
        this.page = this.page + 1;
    };

    this.previous = function() {
        this.page = this.page - 1;
    };

    this.firstPage = function() {
        return this.page === 0;
    };

    this.lastPage = function() {
        return this.page >= this.nPages() - 1;
    };

    this.nPages = function() {
        return Math.ceil($scope.lista.length / this.limit);
    };
});
