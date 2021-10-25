//
//  UvaTableViewController.swift
//  MeuVinho
//
//  Created by Rayana Prata Neves on 25/10/21.
//

import UIKit

class UvaTableViewController: UITableViewController {
    
    var grapes: [Uva] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.reloadTableViewGrape()
    }
    
    func reloadTableViewGrape() {
        do {
            self.grapes = try DataBaseController.persistentContainer.viewContext.fetch(Uva.fetchRequest())
        } catch {
            print("Nao consegui trazer as informaçoes do banco de dados")
        }
        self.tableView.reloadData()
    }
    
    @IBAction func createGrape(_ sender: Any) {
        
        //Criando o primeiro alerta
        let firstAlert = UIAlertController(title: "Adicionar uva", message: "Nome da uva", preferredStyle: .alert)
        //Botao de cancelar o primeiro alerta
        let firstAlertCancelButton = UIAlertAction(title: "Cancelar", style: .default)
        //Botao de ir para o proximo campo do primeiro alerta
        let firstAlertNextButton = UIAlertAction(title: "Próximo", style: .default) { [unowned self] action in
            
            //Criando o segundo alerta
            let secondAlert = UIAlertController(title: "Nova uva",
                                                message: "Tipo da uva",
                                                preferredStyle: .alert)
            //Bora de cancelar do segundo alerta
            let secondAlertCancelButton = UIAlertAction(title: "Cancelar",
                                                        style: .default)
            
            //Botao de terminar do segundo alerta
            let secondAlertFinishButton = UIAlertAction(title: "Terminar", style: .default) { [unowned self] action in
                
                if let grapeName = firstAlert.textFields?.first?.text {
                    if let grapeType = secondAlert.textFields?.first?.text {
                        
                        let context = DataBaseController.persistentContainer.viewContext
                        let grape = Uva(context: context)
                        grape.nome = grapeName
                        grape.tipo = grapeType
                        DataBaseController.saveContext()
                        self.reloadTableViewGrape()
                    }
                }
                
            }
            
            secondAlert.addAction(secondAlertCancelButton)
            secondAlert.addAction(secondAlertFinishButton)
            secondAlert.addTextField()
            
            self.present(secondAlert, animated: true)
            
        }
        
        firstAlert.addTextField()
        firstAlert.addAction(firstAlertCancelButton)
        firstAlert.addAction(firstAlertNextButton)
        
        self.present(firstAlert, animated: true)
        
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return grapes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "uvaTableViewCell", for: indexPath)

        let grape = grapes[indexPath.row]
        
        cell.textLabel?.text = grape.nome
        cell.detailTextLabel?.text = grape.tipo

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
