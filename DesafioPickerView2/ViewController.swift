//
//  ViewController.swift
//  DesafioPickerView2
//
//  Created by André N. dos Santos on 06/05/22.
//

import UIKit

public enum TipoComponente: Int {
    case Horas = 0
    case Minutos = 1
    case Segundos = 2
}

class ViewController: UIViewController {

    @IBOutlet weak var cronometroPickerView: UIPickerView!
    @IBOutlet weak var horarioLabel: UILabel!
    
    var horas: [Int] = []
    var minutos: [Int] = []
    var segundos: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preencheArrayDeHoras()
        preencheArrayDeMinutos()
        preencheArrayDeSegundos()
        horarioLabel.text = ""
        
        cronometroPickerView.dataSource = self
        cronometroPickerView.delegate = self
    }

    @IBAction func iniciarClicked(_ sender: UIButton) {
        let horaSelecionada = obterValorPickerView(.Horas)
        let minutoSelecionado = obterValorPickerView(.Minutos)
        let segundoSelecionado = obterValorPickerView(.Segundos)
        
        horarioLabel.text = "\(horaSelecionada) Horas, \(minutoSelecionado) min e \(segundoSelecionado) seg"
    }
    
    @IBAction func cancelarClicked(_ sender: UIButton) {
        horarioLabel.text = "0 Horas, 0 min e 0 seg"
    }
    
    private func obterValorPickerView(_ numeroDoComponente: TipoComponente) -> Int {
        let array = obterArrayDoComponente(numeroDoComponente)
        let posicaoNoComponente = cronometroPickerView.selectedRow(inComponent: numeroDoComponente.rawValue)
        return array[posicaoNoComponente]
    }
    
    private func preencheArrayDeHoras(){
        for hora in 0..<24 {
            horas.append(hora)
        }
    }
    private func preencheArrayDeMinutos(){
        for minuto in 0..<60 {
            minutos.append(minuto)
        }
    }
    private func preencheArrayDeSegundos(){
        
        for segundo in 0..<60 {
            segundos.append(segundo)
        }
    }
    
    private func obterArrayDoComponente(_ componente: TipoComponente) -> [Int] {
        switch componente {
        case .Horas:
            return horas
        case .Minutos:
            return minutos
        case .Segundos:
            return segundos
        }
    }
    
    private func formataTextoInseridoNoPickerView(tipoComponente: TipoComponente, valor: Int) -> String {
        switch tipoComponente {
        case .Horas:
            return "\(valor) horas"
        case .Minutos:
            return "\(valor) min"
        case .Segundos:
            return "\(valor) seg"
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let tipoComponente = TipoComponente(rawValue: component) else { return 0 }
        return obterArrayDoComponente(tipoComponente).count
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let tipoComponente = TipoComponente(rawValue: component) else { return nil }
        let valor = obterArrayDoComponente(tipoComponente)[row]
        return formataTextoInseridoNoPickerView(tipoComponente: tipoComponente, valor: valor)
    }
}
