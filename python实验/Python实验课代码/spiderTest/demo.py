import re

str = """为内地和香港市场创造双赢
<table class="pci_c" width="400">
	<tbody>
		<tr>
			<td align="center">
				<img src="http://paper.people.com.cn/rmrbhwb/res/1/20191126/1574707289171_1.jpg" /></td>
		</tr>
		<tr>
			<td>
				
					　　近年来，一批内地知名企业先后在港交所上市。图为小米在香港举行上市仪式。<br />
					　　王申摄（新华社发）
			</td>
		</tr>
	</tbody>
</table>

	　　11月17日，“沪港通”运行满5周年了。作为第一座联通内地和香港的“资本桥”，5年来，“沪港通”不仅打通了香港与内地的资本市场，为其注入了新的活力，也为中国内地金融领域改革开放贡献许多宝贵经验，带来重要、积极的影响。
"""
l = []
l = re.findall(r'<table(.*?)</table>', str, re.S)

str = str.replace('<table{}</table>'.format(l[0]), '')

print(str)
