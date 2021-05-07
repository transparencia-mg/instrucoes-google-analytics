# Referência sobre a criação deste app

Referências sobre a criação deste app, incluindo versões Ruby e Rails estão disponíveis no arquivo especificacoes_ruby_on_rails.md

# Automatização Classificações de Acesso Portal da Transparência MG

## Exportação arquivo Google Analytics
1. Acessar [Google Analytics](https://analytics.google.com/) (necessário já estar com acesso. liberado a informações do [Portal da Transparência](http://www.transparencia.mg.gov.br/)).
2. Na barra de opções superior selecionar o site desejado (Todos os dados do website).
3. No menu lateral esquerdo acessar Comportamento>Conteúdo do Site>Página de Destino.
4. Selecione o período desejado na aba lateral direita (Não esqueça de "Aplicar" as modificações).
5. Vá para o final da página e selecione a opção para exibir 5.000 linhas por vez:
    * Observe o número de registros do relatório para prever o número de exportações necessárias; e
    * São gerados, em média 25.000 registros mês, exigindo, portanto a exportação do relatório aprximadamente 5 vezes.
6. Volte para o início da página e clique na opção Exportar>Planilha Google. OUtra opção é exportar como csv para o prórprio HD.
7. Renomeie o arquivo exportado no padrao "portal-paginas-destino-AAAA-MM-VERSAO.csv", exemplo:
    * Primeiro relatório de Março de 2021: portal-paginas-destino-2021-03-01.csv;
    * Quinto relatório de Janeiro de 2020: portal-paginas-destino-2020-01-05.csv; e
    * Segundo relatório de Novembro de 2021: portal-paginas-destino-2021-11-02.csv.
    * Observações:
        * Caso padrão do nome não seja seguido corretamente a classificação poderá não ocorrer corretamente
8. Mova o arquivo exportado para pasta Google Drive correta da DTA - [Portal_Transparencia_Indicadores do Portal](https://drive.google.com/drive/folders/15KuJy3qSzsi9fVAsxrnCmlr_TNUR6iyG?usp=sharing). Observe a necessidade de criação de supastas ano/mês para armazenamento correto do arquivo.

## Exportação arquivo .csv a partir do Google Sheets
1. Duplicar a aba gerada no arquivo Google Sheets (não será necessário renomear a nova aba criada
)
2. Apagar todas as linhas superiores até a linha aonde se iniciar o primeiro registro.
3. Apagar todas as linhas inferiores até a linha do último registro.
4. Exportar o resultado deste trabalho em um arquivo .csv

## Realização classificação automática
1. Acesse [PORTAL DA TRANSPARÊNCIA - GOOGLE ANALYTICS](https://transparencia-google-analytics.herokuapp.com/users/sign_in)
  * Caso não possua login e senha solicitar via e-mail para gabriel.dornas@cge.mg.gov.br
2. No menu lateral esquerdo selecione Links Úteis>Arquivo Google Analytics
  * Ao clicar uma nova aba será aberta com a url - https://transparencia-google-analytics.herokuapp.com/importations/new
    * Caso alguma mensagem de erro ocorra copie e cole a url acima
3. Selecione o arquivo .csv gerado na etapa acima clicando no botão "Choose File"
4. Com arquivo selecionado e clique no botão "Importar Arquivos"
5. Novo arquivo .csv será exportado via Browser COM A CLASSIFICAÇÃO REALIZADA
  * Entre a importação e classificação de um arquivo para outro é necessário atualizar a página

## Unificação dos arquivos, ajustes, validação e publicação
6. Ao final da classificação de todos os arquivos do mês: 
    6.1. unificá-los em uma única planilha
    6.2. alterar a formatação das colunas ``Porcentagem de Novas Sessões`` e ``Taxa de Rejeição`` de porcentagem para número, 
    6.3. rodar a validação interna do pacote frictionless.py e corrigir eventuais inconsistências
7. fazer a inclusão no repositório https://github.com/dados-mg/google-analytics/tree/master/data
    

  * Padrão da nomenclatura:

     - propriedade PORTAL: "portal-paginas-destino-AAAA-MM.csv";
     - propriedade CKAN: "ckan-paginas-destino-AAA-MM.csv"

## Aprimorando o cadastro De-para
1. Acesse [PORTAL DA TRANSPARÊNCIA - GOOGLE ANALYTICS](https://transparencia-google-analytics.herokuapp.com/users/sign_in)
  * Caso não possua login e senha solicitar via e-mail para gabriel.dornas@cge.mg.gov.br
2. No menu lateral esquerdo selecione Navegação>Classificação de URLs
3. Selecione a opção "Criar Novo" e inclua a URL e sua classificação no formulário. Não esqueça de selecionar o botão "Gravar"
  * Não incluir a barra "/" no início do cadastro da url
