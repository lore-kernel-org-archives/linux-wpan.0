Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:59815 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaINVCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Sun, 14 Sep 2014 17:02:31 -0400
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: PATCH IEEE 802.15.4: Add module parameter to mrf24j40 to allow use of external transmitters/receivers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5416009E.1020309@componentsw.com>
Date: Sun, 14 Sep 2014 14:03:19 -0700
Content-Transfer-Encoding: 8BIT
Message-Id: <66EE30B7-8DBD-4EF0-9AA4-9CCB01066CC1@holtmann.org>
References: <5415F84C.9000401@componentsw.com> <7155618F-72E7-4CFD-865F-86A9E1847095@holtmann.org> <5416009E.1020309@componentsw.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Walter Mack <wmack@componentsw.com>
Cc: linux-wpan@vger.kernel.org

Hi Walter,

I would really prefer if you keep the CC list in tact and start using the reply-all button. Also my preference is that people do not top-post on mailing lists.

> I did read through the submittingpatches document, and through the
> coding style document. I must have not understood them.
> 
> For my benefit, could you forward me an email that shows how a good
> patch submission looks like?
> 
> Regarding the style document, I cleaned up what I could see as being not
> conformant (spaces, curly braces), and I don't know what other
> violations I made.

My advise is to use git-format-patch and git-send-email. That makes sure that a lot of details are just done right. And of course git-log has plenty of examples on how other people are writing commit messages.

And the scripts/checkpatch.pl --strict is really what you want. I have not run the script, but I could spot obvious coding style mistakes from a mile away. Either you did it wrong or you mail client is messing up your email. Either way you need to get that fixed.

' might be better as '"Walter J. Mack" <wmack@componentsw.com>
#45: 
Signed-off-by: Walter J. Mack<wmack@componentsw.com>

ERROR: patch seems to be corrupt (line wrapped?)
#57: FILE: drivers/net/ieee802154/mrf24j40.c:27:


ERROR: DOS line endings
#58: FILE: drivers/net/ieee802154/mrf24j40.c:28:
+static bool ext_rx_tx = false ;^M$

ERROR: do not initialise statics to 0 or NULL
#58: FILE: drivers/net/ieee802154/mrf24j40.c:28:
+static bool ext_rx_tx = false ;

WARNING: space prohibited before semicolon
#58: FILE: drivers/net/ieee802154/mrf24j40.c:28:
+static bool ext_rx_tx = false ;

ERROR: DOS line endings
#59: FILE: drivers/net/ieee802154/mrf24j40.c:29:
+module_param(ext_rx_tx, bool, 0444);^M$

ERROR: trailing whitespace
#60: FILE: drivers/net/ieee802154/mrf24j40.c:30:
+MODULE_PARM_DESC(ext_rx_tx, "turn on statemachine to manage external ^M$

ERROR: trailing whitespace
#62: FILE: drivers/net/ieee802154/mrf24j40.c:31:
+^M$

ERROR: trailing whitespace
#70: FILE: drivers/net/ieee802154/mrf24j40.c:70:
+#define REG_TESTMODE   0x22f  /* test mode and state machine control ^M$

ERROR: trailing whitespace
#72: FILE: drivers/net/ieee802154/mrf24j40.c:71:
+^M$

ERROR: DOS line endings
#80: FILE: drivers/net/ieee802154/mrf24j40.c:686:
+    if (ext_rx_tx){^M$

WARNING: please, no spaces at the start of a line
#80: FILE: drivers/net/ieee802154/mrf24j40.c:686:
+    if (ext_rx_tx){^M$

WARNING: suspect code indent for conditional statements (4, 6)
#80: FILE: drivers/net/ieee802154/mrf24j40.c:686:
+    if (ext_rx_tx){
+      ret = write_long_reg(devrec, REG_TESTMODE, 0x0f);

ERROR: space required before the open brace '{'
#80: FILE: drivers/net/ieee802154/mrf24j40.c:686:
+    if (ext_rx_tx){

ERROR: DOS line endings
#81: FILE: drivers/net/ieee802154/mrf24j40.c:687:
+      ret = write_long_reg(devrec, REG_TESTMODE, 0x0f);^M$

WARNING: please, no spaces at the start of a line
#81: FILE: drivers/net/ieee802154/mrf24j40.c:687:
+      ret = write_long_reg(devrec, REG_TESTMODE, 0x0f);^M$

ERROR: DOS line endings
#82: FILE: drivers/net/ieee802154/mrf24j40.c:688:
+      if (ret)^M$

WARNING: please, no spaces at the start of a line
#82: FILE: drivers/net/ieee802154/mrf24j40.c:688:
+      if (ret)^M$

ERROR: DOS line endings
#83: FILE: drivers/net/ieee802154/mrf24j40.c:689:
+        goto err_ret;^M$

ERROR: code indent should use tabs where possible
#83: FILE: drivers/net/ieee802154/mrf24j40.c:689:
+        goto err_ret;^M$

WARNING: please, no spaces at the start of a line
#83: FILE: drivers/net/ieee802154/mrf24j40.c:689:
+        goto err_ret;^M$

ERROR: DOS line endings
#84: FILE: drivers/net/ieee802154/mrf24j40.c:690:
+    }^M$

WARNING: please, no spaces at the start of a line
#84: FILE: drivers/net/ieee802154/mrf24j40.c:690:
+    }^M$

ERROR: DOS line endings
#85: FILE: drivers/net/ieee802154/mrf24j40.c:691:
+^M$

ERROR: DOS line endings
#86: FILE: drivers/net/ieee802154/mrf24j40.c:692:
+^M$

CHECK: Please don't use multiple blank lines
#86: FILE: drivers/net/ieee802154/mrf24j40.c:692:
+
+

total: 17 errors, 8 warnings, 1 checks, 39 lines checked

NOTE: whitespace errors detected, you may wish to use scripts/cleanpatch or
      scripts/cleanfile

Regards

Marcel

