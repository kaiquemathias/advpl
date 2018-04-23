#include "protheus.ch"

/*/{Protheus.doc} KMPX001
//Exemplo de consumo de webservice ViaCep utilizando padrão Json via função FwRest
@author Kaique Mathias
@since 22/04/2018
@version 1.0
/*/

User Function KMPX001()

	Local cBaseUrl 	:= "http://viacep.com.br/ws/"
	Local aHeadStr	:= {"Content-type: application/json"}
	Local oRest		:= Nil
	Local oObjJson	:= Nil
	Local cMsg		:= ""

	oRest := FwRest():New(cBaseUrl)
	oRest:SetPath("78028685/json")

	if oRest:Get(aHeadStr)
		
		cRetorno := oRest:GetResult()
		
		If !FwJsonDeserialize(cRetorno,@oObjJson)
			
			MsgAlert("Ocorreu um erro no processamento do retorno do Json.")
		
		Else
			
			cMsg := "Cep: " + oObjJson:cep + CRLF
			cMsg += "Logradouro: " + DecodeUTF8(oObjJson:logradouro) + CRLF
			cMsg += "complemento: " + DecodeUTF8(oObjJson:complemento) + CRLF
			cMsg += "bairro: " + DecodeUTF8(oObjJson:bairro) + CRLF
			cMsg += "localidade: " + DecodeUTF8(oObjJson:localidade) + CRLF
			cMsg += "uf: " + oObjJson:uf + CRLF
			cMsg += "unidade: " + oObjJson:unidade + CRLF
			cMsg += "ibge: " + oObjJson:ibge + CRLF
			cMsg += "gia: " + oObjJson:gia + CRLF
			
			MsgInfo(cMsg)
		
		EndIf

	endif

Return( Nil )