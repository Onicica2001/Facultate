from infrastructure.repository import RepositoryEmisiuni
from bussiness.service import ServiceEmisiune
from presentation.console import UI
from tests.teste import Teste
test=Teste()
test.run_all_tests()
repository=RepositoryEmisiuni("Emisiuni.txt")
service=ServiceEmisiune(repository)
app=UI(service)
app.run()