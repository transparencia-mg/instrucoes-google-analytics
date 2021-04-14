# Automatização Classificações de Acesso Portal da Transparência MG

## Exportação arquivo Google Analytics
1. Acessar [Google Analytics](https://analytics.google.com/) (necessário já estar com acesso. liberado a informações do [Portal da Transparência](http://www.transparencia.mg.gov.br/)).
2. Na barra de opções superior selecionar o site desejado (Todos os dados do website).
3. No menu lateral esquerdo acessar Comportamento>Conteúdo do Site>Página de Destino.
4. Selecione o período desejado na aba lateral direita (Não esqueça de "Aplicar" as modificações).
5. Vá para o final da página e selecione a opção para exibir 5.000 linhas por vez:
    * Observe o número de registros do relatório para prever o número de exportações necessárias; e
    * São gerados, em média 25.000 registros mês, exigindo, portanto a exportação do relatório aprximadamente 5 vezes.
6. Volte para o início da página e clique na opção Exportar>Planilha Google.
7. Renomei o arquivo exportado no padrao mes_ano_versao, exemplo:
    * Primeiro relatório de Março de 2021: 3_2021_1;
    * Quinto relatório de Janeiro de 2020: 1_2020_5; e
    * Segundo relatório de Novembro de 2021: 11_2021_2.
    * Observações:
        * Não é necessário incluir o dígito 0 nos meses entre janeiro e setembro;
        * Separação entre mes, ano e versão deverá ser feito com [underscore](https://pt.wikipedia.org/wiki/Sublinhado); e
        * Caso padrão do nome não seja seguido corretamente a classificação poderá não ocorrer corretamente
8. Mova o arquivo exportado para pasta Google Drive correta da DTA - [Portal_Transparencia_Indicadores do Portal](https://drive.google.com/drive/folders/15KuJy3qSzsi9fVAsxrnCmlr_TNUR6iyG?usp=sharing). Observe a necessidade de criação de supastas ano/mês para armazenamento correto do arquivo.

## Exportação arquivo .csv a partir do Google Sheets
1. Duplicar a aba gerada no arquivo Google Sheets (não será necessário renomear a nova aba criada
)
2. Apagar todas as linhas superiores até a linha aonde se iniciar o primeiro registro.
3. Apagar todas as linhas inferiores até a linha do último registro.
4. Inserir uma coluna em branco do lado esquerdo da coluna "A" (nova coluna a criada deverá ficar em branco).
5. Colocar em todas as células da nova consulta cridada o nome do arquivo, seguindo o mesmo padrão de nomenclatura sugerido no item 7 do tópico anterior.
    * Dica: Copie e cole o nome do arquivo já modificado.
6. No menu superior direito Google Sheets acesse Arquivo>Download>.csv

## Realização classificação automática
1. Acesse [PORTAL DA TRANSPARÊNCIA - GOOGLE ANALYTICS](https://transparencia-google-analytics.herokuapp.com/users/sign_in)
  * Caso não possua login e senha solicitar via e-mail para gabriel.dornas@cge.mg.gov.br
2. No menu lateral esquerdo selecione Links Úteis>Arquivo Google Analytics
  * Ao clicar uma nova aba será aberta com a url - https://transparencia-google-analytics.herokuapp.com/importations/new
    * Caso alguma mensagem de erro ocorra copie e cole a url acima
3. Selecione o arquivo .csv gerado na etapa acima clicando no botão "Choose File"
4. Com arquivo selecionado e clique no botão "Importar Arquivos"
5. Novo arquivo .csv será exportado via Browser COM A CLASSIFICAÇÃO REALIZADA
  * O consolidado dos arquivos gerados após a classificação deverá ser incluído no repositório https://github.com/dados-mg/google-analytics/tree/master/data

## Aprimorando o cadastro De-para
1. Acesse [PORTAL DA TRANSPARÊNCIA - GOOGLE ANALYTICS](https://transparencia-google-analytics.herokuapp.com/users/sign_in)
  * Caso não possua login e senha solicitar via e-mail para gabriel.dornas@cge.mg.gov.br
2. No menu lateral esquerdo selecione Navegação>Classificação de URLs
3. Selecione a opção "Criar Novo" e inclua a URL e sua classificação no formulário. Não esqueça de selecionar o botão "Gravar"
  * Não incluir a barra "/" no início do cadastro da url



## Dúvidas
- Formatação arquivo .csv exportado
  - "" em string?
  - campos % pode converter para integer (colocar . e retirar %) para explicar do datapackage o tipo de campo?
