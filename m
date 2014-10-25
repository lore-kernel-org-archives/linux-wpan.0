Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34552 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaJYDZg (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 24 Oct 2014 23:25:36 -0400
Received: by mail-lb0-f180.google.com with SMTP id z12so4317lbi.25
        for <linux-wpan@vger.kernel.org>; Fri, 24 Oct 2014 20:25:34 -0700 (PDT)
From: Alexander Aring <alex.aring@gmail.com>
Subject: [PATCH bluetooth-next 1/6] ieee802154: mac802154: remove FSF address
Date: Sat, 25 Oct 2014 05:25:07 +0200
Message-Id: <1414207512-10281-2-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
References: <1414207512-10281-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org
Cc: kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>, Alan Ott <alan@signal11.us>

This patch removes the FSF address in files which belongs to ieee802154
and mac802154.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
Cc: Alan Ott <alan@signal11.us>
---
 drivers/net/ieee802154/at86rf230.c | 4 ----
 drivers/net/ieee802154/fakelb.c    | 4 ----
 drivers/net/ieee802154/mrf24j40.c  | 4 ----
 include/linux/nl802154.h           | 4 ----
 include/net/af_ieee802154.h        | 4 ----
 include/net/ieee802154.h           | 4 ----
 include/net/ieee802154_netdev.h    | 4 ----
 include/net/mac802154.h            | 3 ---
 include/net/nl802154.h             | 4 ----
 include/net/wpan-phy.h             | 4 ----
 net/ieee802154/af802154.h          | 4 ----
 net/ieee802154/af_ieee802154.c     | 4 ----
 net/ieee802154/dgram.c             | 4 ----
 net/ieee802154/ieee802154.h        | 4 ----
 net/ieee802154/netlink.c           | 4 ----
 net/ieee802154/nl-mac.c            | 4 ----
 net/ieee802154/nl-phy.c            | 4 ----
 net/ieee802154/nl_policy.c         | 4 ----
 net/ieee802154/raw.c               | 4 ----
 net/ieee802154/wpan-class.c        | 4 ----
 net/mac802154/ieee802154_dev.c     | 4 ----
 net/mac802154/mac802154.h          | 4 ----
 net/mac802154/mac_cmd.c            | 4 ----
 net/mac802154/mib.c                | 4 ----
 net/mac802154/monitor.c            | 4 ----
 net/mac802154/rx.c                 | 4 ----
 net/mac802154/tx.c                 | 4 ----
 net/mac802154/wpan.c               | 4 ----
 28 files changed, 111 deletions(-)

diff --git a/drivers/net/ieee802154/at86rf230.c b/drivers/net/ieee802154/at86rf230.c
index 6ebd665..b8b1e40 100644
--- a/drivers/net/ieee802154/at86rf230.c
+++ b/drivers/net/ieee802154/at86rf230.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  * Alexander Smirnov <alex.bluesman.smirnov@gmail.com>
diff --git a/drivers/net/ieee802154/fakelb.c b/drivers/net/ieee802154/fakelb.c
index 27d8320..e4b1b1f 100644
--- a/drivers/net/ieee802154/fakelb.c
+++ b/drivers/net/ieee802154/fakelb.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/drivers/net/ieee802154/mrf24j40.c b/drivers/net/ieee802154/mrf24j40.c
index b1e73bc..ba9a396 100644
--- a/drivers/net/ieee802154/mrf24j40.c
+++ b/drivers/net/ieee802154/mrf24j40.c
@@ -13,10 +13,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
 #include <linux/spi/spi.h>
diff --git a/include/linux/nl802154.h b/include/linux/nl802154.h
index 20163b9..167342c 100644
--- a/include/linux/nl802154.h
+++ b/include/linux/nl802154.h
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 #ifndef NL802154_H
diff --git a/include/net/af_ieee802154.h b/include/net/af_ieee802154.h
index 085940f..7d38e2f 100644
--- a/include/net/af_ieee802154.h
+++ b/include/net/af_ieee802154.h
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/include/net/ieee802154.h b/include/net/ieee802154.h
index 0aa7122..4db4e32 100644
--- a/include/net/ieee802154.h
+++ b/include/net/ieee802154.h
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Pavel Smolenskiy <pavel.smolenskiy@gmail.com>
  * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
diff --git a/include/net/ieee802154_netdev.h b/include/net/ieee802154_netdev.h
index 3b53c8e..f874206 100644
--- a/include/net/ieee802154_netdev.h
+++ b/include/net/ieee802154_netdev.h
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Pavel Smolenskiy <pavel.smolenskiy@gmail.com>
  * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
diff --git a/include/net/mac802154.h b/include/net/mac802154.h
index 2e67cdd..f95b98e 100644
--- a/include/net/mac802154.h
+++ b/include/net/mac802154.h
@@ -12,9 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 #ifndef NET_MAC802154_H
 #define NET_MAC802154_H
diff --git a/include/net/nl802154.h b/include/net/nl802154.h
index b23548e..b5cdea2 100644
--- a/include/net/nl802154.h
+++ b/include/net/nl802154.h
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 #ifndef IEEE802154_NL_H
diff --git a/include/net/wpan-phy.h b/include/net/wpan-phy.h
index 10ab0fc..65a05f1 100644
--- a/include/net/wpan-phy.h
+++ b/include/net/wpan-phy.h
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  */
diff --git a/net/ieee802154/af802154.h b/net/ieee802154/af802154.h
index 8330a09..343b63e 100644
--- a/net/ieee802154/af802154.h
+++ b/net/ieee802154/af802154.h
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/ieee802154/af_ieee802154.c b/net/ieee802154/af_ieee802154.c
index 29e0de6..26da1e1 100644
--- a/net/ieee802154/af_ieee802154.c
+++ b/net/ieee802154/af_ieee802154.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
diff --git a/net/ieee802154/dgram.c b/net/ieee802154/dgram.c
index ef2ad8a..71e99a0 100644
--- a/net/ieee802154/dgram.c
+++ b/net/ieee802154/dgram.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/ieee802154/ieee802154.h b/net/ieee802154/ieee802154.h
index 5d352f8..42ae63a 100644
--- a/net/ieee802154/ieee802154.h
+++ b/net/ieee802154/ieee802154.h
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 #ifndef IEEE_802154_LOCAL_H
 #define IEEE_802154_LOCAL_H
diff --git a/net/ieee802154/netlink.c b/net/ieee802154/netlink.c
index 9222966..6c3c259 100644
--- a/net/ieee802154/netlink.c
+++ b/net/ieee802154/netlink.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/ieee802154/nl-mac.c b/net/ieee802154/nl-mac.c
index c6bfe22..78a1529 100644
--- a/net/ieee802154/nl-mac.c
+++ b/net/ieee802154/nl-mac.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/ieee802154/nl-phy.c b/net/ieee802154/nl-phy.c
index 972baf8..e943e20 100644
--- a/net/ieee802154/nl-phy.c
+++ b/net/ieee802154/nl-phy.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/ieee802154/nl_policy.c b/net/ieee802154/nl_policy.c
index 3a703ab8..35c4326 100644
--- a/net/ieee802154/nl_policy.c
+++ b/net/ieee802154/nl_policy.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 #include <linux/kernel.h>
diff --git a/net/ieee802154/raw.c b/net/ieee802154/raw.c
index 9d1f648..3ffcf4a 100644
--- a/net/ieee802154/raw.c
+++ b/net/ieee802154/raw.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/ieee802154/wpan-class.c b/net/ieee802154/wpan-class.c
index 4955e0f..9a2dfab 100644
--- a/net/ieee802154/wpan-class.c
+++ b/net/ieee802154/wpan-class.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  */
 
 #include <linux/slab.h>
diff --git a/net/mac802154/ieee802154_dev.c b/net/mac802154/ieee802154_dev.c
index b36b2b9..6af6a24 100644
--- a/net/mac802154/ieee802154_dev.c
+++ b/net/mac802154/ieee802154_dev.c
@@ -14,10 +14,6 @@
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
 #include <linux/kernel.h>
diff --git a/net/mac802154/mac802154.h b/net/mac802154/mac802154.h
index 762a6f8..e3503c1 100644
--- a/net/mac802154/mac802154.h
+++ b/net/mac802154/mac802154.h
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Pavel Smolenskiy <pavel.smolenskiy@gmail.com>
  * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
diff --git a/net/mac802154/mac_cmd.c b/net/mac802154/mac_cmd.c
index bf80913..85f70ed 100644
--- a/net/mac802154/mac_cmd.c
+++ b/net/mac802154/mac_cmd.c
@@ -12,10 +12,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Sergey Lapin <slapin@ossfans.org>
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
diff --git a/net/mac802154/mib.c b/net/mac802154/mib.c
index 868a040..d7e5df8 100644
--- a/net/mac802154/mib.c
+++ b/net/mac802154/mib.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  * Sergey Lapin <slapin@ossfans.org>
diff --git a/net/mac802154/monitor.c b/net/mac802154/monitor.c
index a68230e..81249bb 100644
--- a/net/mac802154/monitor.c
+++ b/net/mac802154/monitor.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  * Sergey Lapin <slapin@ossfans.org>
diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index a14cf9e..e99d939 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Pavel Smolenskiy <pavel.smolenskiy@gmail.com>
  * Maxim Gorbachyov <maxim.gorbachev@siemens.com>
diff --git a/net/mac802154/tx.c b/net/mac802154/tx.c
index fdf4c0e6..95ea412 100644
--- a/net/mac802154/tx.c
+++ b/net/mac802154/tx.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  * Sergey Lapin <slapin@ossfans.org>
diff --git a/net/mac802154/wpan.c b/net/mac802154/wpan.c
index b796112..c47c96c 100644
--- a/net/mac802154/wpan.c
+++ b/net/mac802154/wpan.c
@@ -10,10 +10,6 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- *
  * Written by:
  * Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
  * Sergey Lapin <slapin@ossfans.org>
-- 
2.1.2

