
import abstracts

from dist.tools.repos.abstract import ARepoManager
from dist.tools.repos import repo


@abstracts.implementer(ARepoManager)
class RPMRepoManager(repo.BaseRepoManager):
    file_types = r".*\.rpm$"

    async def publish(self):
        self.log.warning("TODO! Add createrepo for rpms...")
