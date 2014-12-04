Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from proxima.lasnet.de ([78.47.171.185]:33585 "EHLO
	proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbaLDK6Q (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 4 Dec 2014 05:58:16 -0500
From: Stefan Schmidt <s.schmidt@samsung.com>
Subject: [PATCH bluetooth-next 1/5] net/6lowpan: Remove FSF address from GPL statement.
Date: Thu,  4 Dec 2014 11:51:57 +0100
Message-Id: <1417690321-19450-1-git-send-email-s.schmidt@samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <s.schmidt@samsung.com>, Jukka Rissanen <jukka.rissanen@linux.intel.com>

This might change and we already deliver a copy of the license with
the kernel. This was already removed form the ieee802154 code but
missed here.

Signed-off-by: Stefan Schmidt <s.schmidt@samsung.com>
CC: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/6lowpan/iphc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/6lowpan/iphc.c b/net/6lowpan/iphc.c
index aced97d..32ffec6 100644
--- a/net/6lowpan/iphc.c
+++ b/net/6lowpan/iphc.c
@@ -15,9 +15,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 /* Jon's code is based on 6lowpan implementation for Contiki which is:
-- 
1.9.3

