# Automatização Classificações de Acesso Portal da Transparência MG

## Exportação arquivo Google Analytics
1. Acessar [Google Analytics](https://analytics.google.com/) (necessário já estar com acesso liberado a informações do [Portal da Transparência](http://www.transparencia.mg.gov.br/))
2. Na barra de opções superior selecionar o site desejado (Todos os dados do website)
3. No menu lateral esquerdo acessar Comportamento>Conteúdo do Site>Página de Destino
4. Selecione o período desejado na aba lateral direita (Não esqueça de "Aplicar" as modificações)
5. Vá para o final da página e selecione a opção para exibir 5.000 linhas por vez
    * Observe o número de registros do relatório para prever o número de exportações necessárias
    * São gerados, em média 25.000 registros mês, exigindo, portanto a exportação do relatório aprximadamente 5 vezes
6. Volte para o início da página e clique na opção Exportar>Planilha Google
7. Renomei o arquivo exportado no padrao mes_ano_versao, exemplo
    * Primeiro relatório de Março de 2021: 3_2021_1
    * Quinto relatório de Janeiro de 2020: 1_2020_5
    * Segundo relatório de Novembro de 2021: 11_2021_2
    * Observações:
        * Não é necessário incluir 0 nos meses entre janeiro e setembro
    - separação entre mes, ano e versão deverá ser feito com [underscore](https://pt.wikipedia.org/wiki/Sublinhado)
    - Caso padrão do nome não seja seguido corretamente a classificação poderá não ocorrer corretamente
- Mova o arquivo exportado para pasta Google Drive correta da DTA - [Portal_Transparencia_Indicadores do Portal](https://drive.google.com/drive/folders/15KuJy3qSzsi9fVAsxrnCmlr_TNUR6iyG?usp=sharing)

## Exportação arquivo .csv a partir do Google Sheets
- Duplicar a aba gerada no arquivo Google Sheets (não será necessário renomear a nova aba criada
)
- Apagar todas as linhas superiores até a linha aonde se iniciar o primeiro registro
- Apagar todas as linhas inferiores até a linha do último registro
- Inserir uma coluna em branco do lado esquerdo da coluna "A" (nova coluna a criada deverá ficar em branco)
- Colocar em todas as células da nova consulta cridada o nome do arquivo, seguindo o mesmo padrão de nomenclatura sugerido acima


