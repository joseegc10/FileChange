var entities = [{
  "id": 1,
  "typeString": "enum",
  "cases": [
    {
  "name": "login case register case logueado case valoraciones case inicio"
}
  ],
  "name": "TipoInicio"
},{
  "id": 2,
  "typeString": "class",
  "properties": [
    {
  "name": "var estado: TipoInicio",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "login(email: String, password: String, completion: @escaping (_ done: Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "register(email: String, password: String, completion: @escaping (_ done: Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FirebaseAuth",
  "superClass": 41
},{
  "id": 3,
  "typeString": "class",
  "properties": [
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var misArchivos",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var misDescargas",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var filesValorar",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var filesRecomendados",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var user",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var file: Data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var filesTipo",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let tiposPosibles: [String]",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "addFile(file: FileModel, completion: @escaping (Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "addUserInfo(user: UserModel)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "docEnUser(valor: [String:Any], id: String) -> UserModel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getUserInfo()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "docEnFile(document: QueryDocumentSnapshot) -> FileModel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "docEnFile(valor: [String:Any], id: String) -> FileModel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getUserFiles(cadena: String? = nil)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getUserDownloads(cadena: String? = nil)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "editFile(file: FileModel, completion: @escaping (Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "editFileWithImage(file: FileModel, completion: @escaping (Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "deleteFile(file: FileModel, completion: @escaping (Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getFile(url: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "busquedaFiles(nombreBuscado: String, tipoBuscado: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "busquedaFilesTipo(tipoBuscado: String, completion: @escaping (Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "aniadeDescarga(idFile: String, tipo: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getFilesAValorar(completion: @escaping (Bool) -> Void)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "deleteFileValorar(idFile: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "aniadeValoracion(idFile: String, valoracion: Int)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "actualizaFilesTipo(tipo: String)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "getFilesRecomendados(cadena: String? = nil)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FileViewModel",
  "superClass": 41
},{
  "id": 4,
  "typeString": "class",
  "properties": [
    {
  "name": "var conexion : ImagePicker",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "imagePickerControllerDidCancel(_ picker: UIImagePickerController)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(conexion: ImagePicker)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    43,
    44
  ],
  "name": "Coordinator",
  "superClass": 42
},{
  "id": 5,
  "typeString": "struct",
  "properties": [
    {
  "name": "var show : Bool @Binding",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var image : Data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var source : UIImagePickerController.SourceType",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "makeCoordinator() -> ImagePicker.Coordinator",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "makeUIViewController(context: Context) -> some UIImagePickerController",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updateUIViewController(_ uiViewController: UIViewControllerType, context: Context)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ImagePicker",
  "superClass": 45,
  "containedEntities": [
    4
  ]
},{
  "id": 6,
  "typeString": "class",
  "properties": [
    {
  "name": "var data : Data?",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var documentURL : String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "load()",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(documentURL: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "DocumentViewModel",
  "superClass": 41
},{
  "id": 7,
  "typeString": "class",
  "properties": [
    {
  "name": "var parent: FilePicker",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL])",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(parent1: FilePicker)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "Coordinator",
  "superClass": 42
},{
  "id": 8,
  "typeString": "struct",
  "properties": [
    {
  "name": "var file: FileModel",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "makeCoordinator() -> FilePicker.Coordinator",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "makeUIViewController(context: UIViewControllerRepresentableContext<FilePicker>) -> UIDocumentPickerViewController",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: UIViewControllerRepresentableContext<FilePicker>)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FilePicker",
  "superClass": 45,
  "containedEntities": [
    7
  ]
},{
  "id": 9,
  "typeString": "enum",
  "protocols": [
    47
  ],
  "cases": [
    {
  "name": "libro"
},
    {
  "name": "comic"
},
    {
  "name": "poema"
},
    {
  "name": "revista"
},
    {
  "name": "apuntes"
},
    {
  "name": "otro"
}
  ],
  "name": "TipoFile",
  "superClass": 46
},{
  "id": 10,
  "typeString": "struct",
  "properties": [
    {
  "name": "var id: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var titulo: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var descripcion: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var portada: Data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var dirPortada: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var archivo: Data",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var dirArchivo: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var valoracionMedia: Double",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var numValoraciones: Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var idCreador: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var tipoArchivo: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var nombreAutor: String",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    49
  ],
  "name": "FileModel",
  "superClass": 48
},{
  "id": 11,
  "typeString": "struct",
  "properties": [
    {
  "name": "var id: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var nombre: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var apellidos: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var correo: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var valoracionesPendientes: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var descargas: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var descargasTipo",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "UserModel",
  "superClass": 48
},{
  "id": 12,
  "typeString": "struct",
  "properties": [
    {
  "name": "var file: FileModel @State",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var estoyEdit",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var estoyViendo",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let idUser",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FileCardView",
  "superClass": 50
},{
  "id": 13,
  "typeString": "struct",
  "properties": [
    {
  "name": "var file",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var saveFile",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var ext",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let fileUrl",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FileView",
  "superClass": 50
},{
  "id": 14,
  "typeString": "struct",
  "properties": [
    {
  "name": "var readableContentTypes: [UTType]",
  "type": "type",
  "accessLevel": "internal"
},
    {
  "name": "var data: Data",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(data: Data)",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(configuration: ReadConfiguration) throws",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "Doc",
  "superClass": 51
},{
  "id": 15,
  "typeString": "struct",
  "properties": [
    {
  "name": "var file",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let tiposPosibles: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var tipoElegido: [String:Bool]",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var editar: Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var elegirCapacidad",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var alerta",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var centerCoordinate",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var imageData : Data",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var mostrarMenu",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var imagePicker",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var source : UIImagePickerController.SourceType",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var fileName",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var elegirFile",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var elegido",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let bucket",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let idUser",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "AddEditFileView",
  "superClass": 50
},{
  "id": 16,
  "typeString": "struct",
  "properties": [
    {
  "name": "var tipo: String @StateObject",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var titulo",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var isEditing",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "TypeFileView",
  "superClass": 50
},{
  "id": 17,
  "typeString": "enum",
  "cases": [
    {
  "name": "archivos"
},
    {
  "name": "descargas"
},
    {
  "name": "recomendados"
}
  ],
  "name": "TipoLista"
},{
  "id": 18,
  "typeString": "struct",
  "properties": [
    {
  "name": "var misArchivos: TipoLista @StateObject",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var titulo",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var isEditing",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ListaFilesView",
  "superClass": 50
},{
  "id": 19,
  "typeString": "struct",
  "properties": [
    {
  "name": "var files: [FileModel] @State",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var miFile",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ScrollFilesView",
  "superClass": 50
},{
  "id": 20,
  "typeString": "struct",
  "properties": [
    {
  "name": "var nombre: String",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var tipo: String",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var isEditing",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var miFile",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "BuscarView",
  "superClass": 50
},{
  "id": 21,
  "typeString": "struct",
  "properties": [
    {
  "name": "var email",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var password",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var login",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var estado: FirebaseAuth",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "LoginView",
  "superClass": 50
},{
  "id": 22,
  "typeString": "struct",
  "properties": [
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "LoadView",
  "superClass": 50
},{
  "id": 23,
  "typeString": "struct",
  "properties": [
    {
  "name": "var login: FirebaseAuth @State",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var listaFiles",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "PrincipalView",
  "superClass": 50
},{
  "id": 24,
  "typeString": "struct",
  "properties": [
    {
  "name": "var person",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var archivos",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var estado: FirebaseAuth @State",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var misArchivos",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var misDescargas",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "AccountView",
  "superClass": 50
},{
  "id": 25,
  "typeString": "struct",
  "methods": [
    {
  "name": "body(content: Content) -> some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "CardModifier",
  "superClass": 52
},{
  "id": 26,
  "typeString": "struct",
  "properties": [
    {
  "name": "var presentation",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let tiposPosibles: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var libro",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var comic",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var poema",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var revista",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var apuntes",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var otro",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var activar: Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "InitView",
  "superClass": 50
},{
  "id": 27,
  "typeString": "struct",
  "properties": [
    {
  "name": "var email",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var password",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var nombre",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var apellidos",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var login",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var estado: FirebaseAuth @StateObject",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var usuarios",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let user",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "RegisterView",
  "superClass": 50
},{
  "id": 28,
  "typeString": "struct",
  "properties": [
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "init()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "MenuView",
  "superClass": 50
},{
  "id": 29,
  "typeString": "struct",
  "properties": [
    {
  "name": "var imageLoader: DocumentViewModel",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let imageURL: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let anchura: CGFloat",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let tipo: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ImagenStorageView",
  "superClass": 50
},{
  "id": 30,
  "typeString": "struct",
  "properties": [
    {
  "name": "let id: Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var title: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var selected: Bool",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "init (id: Int, title: String, selected: Bool)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    49
  ],
  "name": "Tipo"
},{
  "id": 31,
  "typeString": "struct",
  "properties": [
    {
  "name": "var Categories: [Tipo]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var lastIndex: Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var selectedTitle: String @State",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var currentIndex: Int",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var ns",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var index",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let tipoInicial: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "methods": [
    {
  "name": "init(selectedTitle: Binding<String>, tipoInicial: String)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "TiposPickerView",
  "superClass": 50
},{
  "id": 32,
  "typeString": "struct",
  "methods": [
    {
  "name": "body(content: Content) -> some View",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "init(backgroundColor: UIColor, tintColor: UIColor)",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "NavigationBarColor",
  "superClass": 52
},{
  "id": 34,
  "typeString": "struct",
  "properties": [
    {
  "name": "var miValoracion: Int",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var siguiente",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var termina",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var listaFiles: [FileModel] @State",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var siguienteFile",
  "type": "instance",
  "accessLevel": "private"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var login: FirebaseAuth",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ValoracionesView",
  "superClass": 50
},{
  "id": 35,
  "typeString": "struct",
  "properties": [
    {
  "name": "var texto: String",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "MyNavigationView",
  "superClass": 50
},{
  "id": 36,
  "typeString": "struct",
  "properties": [
    {
  "name": "var activar: Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var tipo: String @StateObject",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "NavigationTypeView",
  "superClass": 50
},{
  "id": 37,
  "typeString": "class",
  "methods": [
    {
  "name": "application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "protocols": [
    54
  ],
  "name": "AppDelegate",
  "superClass": 53
},{
  "id": 38,
  "typeString": "struct",
  "properties": [
    {
  "name": "var appDelegate",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some Scene",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let login",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "FileChangeApp",
  "superClass": 55
},{
  "id": 39,
  "typeString": "struct",
  "properties": [
    {
  "name": "var presentation",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "let tiposPosibles: [String]",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var files",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var libro",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var comic",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var poema",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var revista",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var apuntes",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var otro",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var activar: Bool",
  "type": "instance",
  "accessLevel": "internal"
},
    {
  "name": "var body: some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "name": "ContentView",
  "superClass": 50
},{
  "id": 41,
  "typeString": "class",
  "name": "ObservableObject"
},{
  "id": 42,
  "typeString": "class",
  "name": "NSObject"
},{
  "id": 43,
  "typeString": "protocol",
  "name": "UIImagePickerControllerDelegate"
},{
  "id": 44,
  "typeString": "protocol",
  "name": "UINavigationControllerDelegate"
},{
  "id": 45,
  "typeString": "class",
  "name": "UIViewControllerRepresentable"
},{
  "id": 46,
  "typeString": "class",
  "name": "String"
},{
  "id": 47,
  "typeString": "protocol",
  "name": "CaseIterable"
},{
  "id": 48,
  "typeString": "class",
  "name": "Identifiable"
},{
  "id": 49,
  "typeString": "protocol",
  "name": "Hashable"
},{
  "id": 50,
  "typeString": "class",
  "name": "View",
  "extensions": [
    33,
    40
  ]
},{
  "id": 51,
  "typeString": "class",
  "name": "FileDocument"
},{
  "id": 52,
  "typeString": "class",
  "name": "ViewModifier"
},{
  "id": 53,
  "typeString": "class",
  "name": "UIResponder"
},{
  "id": 54,
  "typeString": "protocol",
  "name": "UIApplicationDelegate"
},{
  "id": 55,
  "typeString": "class",
  "name": "App"
},{
  "id": 33,
  "typeString": "extension",
  "methods": [
    {
  "name": "navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "View"
},{
  "id": 40,
  "typeString": "extension",
  "methods": [
    {
  "name": "hideKeyboard()",
  "type": "instance",
  "accessLevel": "internal"
}
  ],
  "extendedEntityName": "View"
}] 