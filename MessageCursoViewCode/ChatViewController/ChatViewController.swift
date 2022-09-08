//
//  ChatViewController.swift
//  MessageCursoViewCode
//
//  Created by Raphael Augusto on 23/08/22.
//

import UIKit
import Firebase
import AVFoundation

class ChatViewController: UIViewController {
    
    var listaMensagens: [Message] = []
    var idUsuarioLogado: String?
    var contato: Contact?
    var mensagemListener: ListenerRegistration?
    var auth: Auth?
    var db: Firestore?
    var nomeContato: String?
    var nomeUsuarioLogado: String?

    var screen: ChatViewScreen?
    
    
    override func loadView() {
        self.screen = ChatViewScreen()
        self.view = screen
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configDataFireBase()
        configChatView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.addListenerRetrieveMessage()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.mensagemListener?.remove()
    }
    
    
    private func configDataFireBase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        //Retrieve the logged in ID
        if let id = self.auth?.currentUser?.uid {
            self.idUsuarioLogado = id
            self.recuperarDadosUsuarioLogado()
        }
        
        if let nome = self.contato?.nome {
            self.nomeContato = nome
        }
    }
    
    func addListenerRetrieveMessage() {
        if let idDestinatario = self.contato?.id {
            self.mensagemListener = db?.collection("mensagens").document(self.idUsuarioLogado ?? "").collection(idDestinatario).order(by: "data",  descending: true).addSnapshotListener({ querySnapShot, error in
                
                //clean all messagem
                self.listaMensagens.removeAll()
                
                //recover data
                if let snapShot = querySnapShot {
                    for document in snapShot.documents {
                        let dados = document.data()
                        self.listaMensagens.append(Message(dicionario: dados))
                    }
                    self.screen?.reloadTableView()
                }
            })
        }
    }
    
    
    private func recuperarDadosUsuarioLogado() {
        let usuarios = self.db?.collection("usuarios").document(self.idUsuarioLogado ?? "")
        usuarios?.getDocument(completion: { documentSnapShot, error in
            if error == nil {
                let dados: Contact = Contact(dicionario: documentSnapShot?.data() ?? [:])
                self.nomeUsuarioLogado = dados.nome ?? ""
            }
        })
    }
    
    
    private func configChatView() {
        self.screen?.configNavView(controller: self)
        self.screen?.configTableView(delegate: self, dataSource: self)
        self.screen?.delegate(delegate: self)
    }
    
    
    private func saveMessage(idRemetente: String, idDestinatario: String, mensagem: [String: Any]) {
        self.db?.collection("mensagens").document(idRemetente).collection(idDestinatario).addDocument(data: mensagem)
        
        //clear message box
        self.screen?.inputMessageTextField.text = ""
    }
    
    
    private func saveConversation(idRemetente: String, idDestinatario: String, conversa: [String: Any]) {
        self.db?.collection("conversas").document(idRemetente).collection("ultimas_conversas").document(idDestinatario).setData(conversa)
    }
}


//MARK: - Action
extension ChatViewController {
    
    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}


//MARK: - Delegate and DataSource UITableView
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listaMensagens.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indice = indexPath.row
        let dados = self.listaMensagens[indice]
        let idUsuario = dados.idUsuario ?? ""
        
        if self.idUsuarioLogado != idUsuario {
            //message left
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTableViewCell.identifier, for: indexPath) as? IncomingTextMessageTableViewCell
            
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: dados)
            cell?.selectionStyle = .none
            
            return cell ?? UITableViewCell()
        } else {
            //message right
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTableViewCell.identifier, for: indexPath) as? OutgoingTextMessageTableViewCell
            
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.setupCell(message: dados)
            cell?.selectionStyle = .none
            
            return cell ?? UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desc: String = self.listaMensagens[indexPath.row].texto ?? ""
        let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
        let estimateHeight = desc.heightWithConstrainedWidth(width: 220, font: font)
        
        return CGFloat(65 + estimateHeight)
    }
}


//MARK: - Protocol
extension ChatViewController: ChatViewScreenProtocol {
    
    func actionPushMessage() {
        let message: String = self.screen?.inputMessageTextField.text ?? ""
        
        if let idUsuarioDestinatario = self.contato?.id {
            
            let mensagem: Dictionary<String, Any> = [
                "idUsuario": self.idUsuarioLogado ?? "",
                "texto": message,
                "data": FieldValue.serverTimestamp()
            ]
            
            //message to sender
            self.saveMessage(idRemetente: self.idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, mensagem: mensagem)
            
            //message to recipient
            self.saveMessage(idRemetente: idUsuarioDestinatario, idDestinatario: self.idUsuarioLogado ?? "", mensagem: mensagem)
            
            //save conversation
            var conversa:Dictionary<String,Any> = ["ultimaMenssagem": mensagem]
            
            //receive
            conversa["idRemetente"]             = idUsuarioLogado ?? ""
            conversa["idUsuarioDestinatario"]   = idUsuarioDestinatario
            conversa["nomeUsuario"]             = self.nomeContato ?? ""
            self.saveConversation(idRemetente: idUsuarioLogado ?? "", idDestinatario: idUsuarioDestinatario, conversa: conversa)
            
            //send
            conversa["idRemetente"]             = idUsuarioDestinatario
            conversa["idUsuarioDestinatario"]   = idUsuarioLogado ?? ""
            conversa["nomeUsuario"]             = self.nomeUsuarioLogado ?? ""
            self.saveConversation(idRemetente: idUsuarioDestinatario, idDestinatario: idUsuarioLogado ?? "", conversa: conversa)
        }
    }
}
