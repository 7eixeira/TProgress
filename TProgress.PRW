#include "protheus.ch"

/*                                                                                  
  +-----------------------------------------------------------------------------------------------------------------+  
  | CLASSE    | TProgress.prw        | AUTOR | J.TEIXEIRA              | DATA | 29/03/12                            |
  +-----------------------------------------------------------------------------------------------------------------+    
  | DESCRICAO | Classe para uso interno                                                                             |  
  |           |                                                                                                     |  
  |                                                                                                                 |
  |                                                                                                                 |
  +-----------------------------------------------------------------------------------------------------------------+    
  | MANUTENCAO DESDE SUA CRIACAO                                                				                    |   
  +-----------------------------------------------------------------------------------------------------------------+    
  | DATA     | AUTOR                | DESCRICAO                                 				                    |  
  +-----------------------------------------------------------------------------------------------------------------+    
 */  
                                      
class TProgress
   data lNew as logical
	data oBack readOnly
	data oBack2 readOnly
	data oSay readOnly
	data oSayBack readOnly
	data oSayBack2 readOnly
	data oPr readOnly
	data cMsg
	data cMsg2      
	data oDlg
	data Pn
	data oTFontMsg
	data nTotal
    method New( oDlg ) Constructor
    method processBar( nRecno, nLastRec )
    method setMessage( cMsg, cMsg2 ) 
    method run( nInc, nTotal )
    method reset()
    method setProgress( nTotal )
    data aTables as array readOnly
end class

method New( oDlg ) class TProgress
local cStyle2 := " Q3Frame{ background-color: qlineargradient(spread:pad, x1:0, y1:1, x2:0, y2:0, stop:0.03 rgba(48, 48, 48, 255), stop:0.56743 rgba(80, 80, 80, 255), stop:0.620865 rgba(48, 48, 48, 255), stop:0.945 rgba(127, 127, 127, 255), stop:1 rgba(122, 207, 42, 255)); border: 0px; }"
local cPrCss1 := ""
local aCords := GETSCREENRES() // 1 - largura, 2 - altura
cPrCss1 += " QProgressBar:horizontal { "
cPrCss1 += " border: 0px solid gray; "
cPrCss1 += " border-radius: 0px; "
//cPrCss1 += " border: 1px solid gray; "
//cPrCss1 += " border-radius: 3px; "
cPrCss1 += " background: white; "
cPrCss1 += " padding: 0px; "
cPrCss1 += " } "
cPrCss1 += " QProgressBar::chunk:horizontal { "
cPrCss1 += " background: qlineargradient(x1: 0, y1: 0.10, x2: 1, y2: 0.15, stop: 0 #7FFF00, stop: 1 green ); "
//cPrCss1 += " background:qlineargradient(spread:reflect, x1:0.500318, y1:1, x2:1, y2:0.1, stop:0.0795455 rgba(83, 126, 170, 255), stop:1 rgba(234, 254, 255, 227)); border: 1px solid rgb(0,196,225) } ; "
cPrCss1 += " } "

::oTFontMsg := TFont():New('Calibri',,-10,.T.)

::cMsg := Space(100)
::cMsg2 := Space(100)

::cMsg:= " "
::cMsg2:= " "
::oDlg := oDlg


::Pn:= TPanelCss():New( 150, 160,"",::oDlg,,.F.,.F.,SetTransparentColor(CLR_BLACK ,140),,200,60,.T.,.T.)
::Pn:SetCSS( cStyle2 )

  // Painel com aplicação de transparência
  ::oBack := TPanel():New(00,00,"",oDlg,,.F.,.F.,,;
      SetTransparentColor(CLR_BLACK ,110),aCords[2],aCords[1],.T.,.F.)

  ::oBack2 := TPanel():New(00,00,"",oDlg,,.F.,.F.,,;
      SetTransparentColor(CLR_BLACK ,140),aCords[2],aCords[1],.T.,.F.)

   ::oSay:= TSay():New(153,240,{||'Aguarde, processando...'},::oBack2,,::oTFontMsg,,;
                     ,,.T.,CLR_WHITE,CLR_WHITE,200,20)


::oPr:=TMeter():New(180,170,,100,::oBack2,180,10,,.T.,::oTFontMsg,"",.T.,,,GetSysColor(13),GetSysColor(),.T.) 
::oPr:SetCSS( cPrCss1 )
::oPr:Set(0)
::oPr:lPercentage:= .T.

::oSayBack:= TSay():New(190,240,{|| ::cMsg },::oBack2,,::oTFontMsg,,;
                     ,,.T.,CLR_WHITE,CLR_WHITE,200,40)


::oSayBack2:= TSay():New(165,200,{|| ::cMsg2 },::oBack2,,::oTFontMsg,,;
                     ,,.T.,CLR_WHITE,CLR_WHITE,200,40)


return self


method processBar( nRecno, nLastRec ) class TProgress
local nMeter := 0

While nMeter < nLastRec
		nMeter := nMeter + 1
		::cMsg := LTRIM(STR(INT((nMeter/nLastRec) * 100))) + "% Completada." 
		
	    Sleep(100)
		::oPr:Set( nMeter )
		::oPr:Refresh()
		::oSayBack:Refresh()

End	

::oBack:Hide()
::oBack2:Hide()
::Pn:Hide()

return

method setMessage( cMsg, cMsg2 )  class TProgress

	::cMsg2:=cMsg2
	::oSayBack2:Refresh()

return

method setProgress( nTotal ) class TProgress
	::nTotal:=nTotal
	::oPr:nTotal := nTotal
return

method run( nInc , nTotal ) class TProgress
		
		::oPr:nTotal := 100

		::cMsg := LTRIM(STR(INT((nInc/nTotal) * 100))) + "% Completada." 
		
			    
		::oPr:Set(  INT((nInc/nTotal) * 100) )
		::oPr:Refresh()
		::oSayBack:Refresh()
		

return

method reset() class TProgress
	::cMsg:= " "
	::cMsg2:= " "
	::oPr:Set(0)
	::oPr:nTotal := 100
	::oPr:Refresh()
	::oSayBack:Refresh()
	::oSayBack2:Refresh()
return

