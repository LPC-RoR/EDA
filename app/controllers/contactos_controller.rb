class ContactosController < ApplicationController
  before_action :inicia_sesion
  before_action :carga_temas_ayuda
  before_action :set_contacto, only: [:show, :edit, :update, :destroy]

  # GET /contactos
  # GET /contactos.json
  def index
    @activo = Perfil.find(session[:perfil_activo]['id'])

    @tabs = ['ingreso', 'enviados', 'recibidos', 'cerrados']
    if params[:html_options].blank?
      @tab = 'recibidos'
    else
      @tab = params[:html_options][:tab].blank? ? 'recibidos' : params[:html_options][:tab]
    end
    @options = { 'tab' => @tab }

    @coleccion = {}


    coleccion_base = session[:es_administrador] ? Contacto.all : @activo.contactos
    encabezados = coleccion_base.where.not(tipo: 'respuesta')

    autenticados = Contacto.where.not(perfil_id: nil)
    ids_administrativos = autenticados.map {|aut| aut.id if aut.perfil.administrador.present?}.compact

    ## INGRESO
    # En 'ingreso' deben estar MENSAJES Y RESPUESTAS sin enviar
    if @tab == 'ingreso'
      if session[:es_administrador]
        @coleccion[controller_name] = coleccion_base.where(id: ids_administrativos).where(estado: 'ingreso').order(sended_at: :desc)
      else
        @coleccion[controller_name] = coleccion_base.where(estado: @tab.singularize).order(sended_at: :desc)
      end
    ## CERRADOS
    # En 'cerrados' se muestran sólo los encabezados. A través de ellos se puede acceder a las respuestas
    # Para la administración se muestran TODOS los cerrados, los generados por usuarios también
    elsif @tab == 'cerrados'
      @coleccion[controller_name] = encabezados.where(estado: 'cerrado')
    else
      enviados = encabezados.where(estado: 'enviado')

      ids_con_respuesta = enviados.map {|pend| pend.id if pend.children.any?}.compact
      ids_sin_respuesta = enviados.map {|pend| pend.id if pend.children.empty?}.compact

      ## ENVIADOS
      if @tab == 'enviados'
        # A un administrador se le muestran TODOS los mensajes que ha creado, sin importar el estado
        if session[:es_administrador]
          @coleccion[controller_name] = enviados.where(id: ids_administrativos).order(sended_at: :desc)
        # A un usuario, se le muestra todo lo creado que NO ha sido cerrado
        else
          @coleccion[controller_name] = enviados.where.not(id: ids_administrativos).order(sended_at: :desc)
        end
      elsif @tab == 'recibidos'
        ids_usuario_sin_respuesta = (ids_sin_respuesta - ids_administrativos)
        ids_usuario_con_respuesta = (ids_con_respuesta - ids_administrativos)
        usuario_con_respuesta = Contacto.where(id: ids_usuario_con_respuesta)
        ## ADMINISTRADOR
        # Los ENVIADOS POR USUARIOS SIN RESPUESTA + CON RESPUESTA CUYA ULTIMA RESPUESTA ES DEL USUARIO
        if session[:es_administrador]
          ids_usuario_con_respuesta_usuario = usuario_con_respuesta.map {|msg| msg.id if msg.children.order(sended_at: :desc).first.perfil.administrador.blank?}.compact
          ids_coleccion = (ids_usuario_sin_respuesta | ids_usuario_con_respuesta_usuario)
        ## USUARIO
        # Los ENVIADOS POR LA ADMINSITRACIÖN + ENVIADOS POR USUARIO CUYA ULTIMA RESPUESTA ES DE LA ADMINSITRACIÓN
        else
          ids_enviados_adm = enviados.where(id: ids_administrativos).order(sended_at: :desc)
          ids_usuario_con_respuesta_admin = usuario_con_respuesta.map {|msg| msg.id if msg.children.order(sended_at: :desc).first.perfil.administrador.present?}.compact
          ids_coleccion = (ids_enviados_adm | ids_usuario_con_respuesta_admin)
        end
        @coleccion[controller_name] = coleccion_base.where(id: ids_coleccion).order(sended_at: :desc)
      end
    end

  end

  # GET /contactos/1
  # GET /contactos/1.json
  def show
  end

  # GET /contactos/new
  def new
    if usuario_signed_in?
      perfil_id = session[:perfil_activo]['id']
      tipo      = session[es_administrador] ? 'administrador' : 'usuario'
      estado    = 'ingreso'
    else
      perfil_id = nil
      tipo      = 'anónimo'
      estado    = 'enviado'
    end
    @objeto = Contacto.new(estado: estado, sended_at: DateTime.current, perfil_id: perfil_id, tipo: tipo)
  end

  # GET /contactos/1/edit
  def edit
  end

  # POST /contactos
  # POST /contactos.json
  def create
    @objeto = Contacto.new(contacto_params)

    respond_to do |format|
      if @objeto.save
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Contacto was successfully created.' }
        format.json { render :show, status: :created, location: @objeto }
      else
        format.html { render :new }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contactos/1
  # PATCH/PUT /contactos/1.json
  def update
    respond_to do |format|
      if @objeto.update(contacto_params)
        set_redireccion
        format.html { redirect_to @redireccion, notice: 'Contacto was successfully updated.' }
        format.json { render :show, status: :ok, location: @objeto }
      else
        format.html { render :edit }
        format.json { render json: @objeto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contactos/1
  # DELETE /contactos/1.json
  def destroy
    set_redireccion
    @objeto.destroy
    respond_to do |format|
      format.html { redirect_to @redireccion, notice: 'Contacto was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacto
      @objeto = Contacto.find(params[:id])
    end

    def set_redireccion
      @redireccion = (usuario_signed_in? ? contactos_path : root_path)
    end

    # Only allow a list of trusted parameters through.
    def contacto_params
      params.require(:contacto).permit(:tipo, :estado, :contacto, :perfil_id, :padre_id, :detalle, :email, :sended_at, :tipo)
    end
end
