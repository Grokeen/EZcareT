import pandas as pd
excel_file = pd.ExcelFile('/20240903112204.xlsx')
sheet_names = excel_file.sheet_names
sheet_names
df = pd.read_excel('20240903112204.xlsx', sheet_name='Sheet 1')
df.head()
markdown_table = df.to_markdown(index=False)
markdown_table