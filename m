Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:51533 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729761AbfCYVgs (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>);
        Mon, 25 Mar 2019 17:36:48 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 54D5F1801812C
        for <linux-wpan@vger.kernel.org>; Mon, 25 Mar 2019 21:27:06 +0000 (UTC)
From: Joe Perches <joe@perches.com>
Subject: Bad file pattern in MAINTAINERS section 'IEEE 802.15.4 SUBSYSTEM'
Date: Mon, 25 Mar 2019 14:27:01 -0700
Message-Id: <20190325212701.26768-1-joe@perches.com>
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, linux-wpan@vger.kernel.org, Varka Bhadram <varkab@cdac.in>, Marcel Holtmann <marcel@holtmann.org>, "David S . Miller" <davem@davemloft.net>

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	7509	IEEE 802.15.4 SUBSYSTEM
	7510	M:	Alexander Aring <alex.aring@gmail.com>
	7511	M:	Stefan Schmidt <stefan@datenfreihafen.org>
	7512	L:	linux-wpan@vger.kernel.org
	7513	W:	http://wpan.cakelab.org/
	7514	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan.git
	7515	T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sschmidt/wpan-next.git
	7516	S:	Maintained
	7517	F:	net/ieee802154/
	7518	F:	net/mac802154/
	7519	F:	drivers/net/ieee802154/
	7520	F:	include/linux/nl802154.h
	7521	F:	include/linux/ieee802154.h
	7522	F:	include/net/nl802154.h
	7523	F:	include/net/mac802154.h
	7524	F:	include/net/af_ieee802154.h
	7525	F:	include/net/cfg802154.h
	7526	F:	include/net/ieee802154_netdev.h
-->	7527	F:	Documentation/networking/ieee802154.txt

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'Documentation/networking/ieee802154.txt':

commit ebef9c1236170fb3ba4dc05ccb41f6d842eb1c12
Author: Varka Bhadram <varkab@cdac.in>
Date:   Fri Aug 8 17:32:45 2014 +0530

    MAINTAINERS: update maintainers info
    
    adds the mailing list address for bluetooth 6loWPAN and
    IEEE-802.15.4 subsystems. Also adds web page info.
    
    Signed-off-by: Varka Bhadram <varkab@cdac.in>
    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>

 MAINTAINERS | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

3: ---------------------------------------------------------------------------

The last commit with a real presence of file pattern 'Documentation/networking/ieee802154.txt':

commit 8a42eda2582ada073d7320ca703fb5fa49600e87
Author: Stefan Schmidt <stefan@datenfreihafen.org>
Date:   Wed Feb 27 20:59:14 2019 +0100

    doc: net: ieee802154: remove old plain text docs after switching to rst
    
    The plain text docs are converted to rst now, which allows us to remove
    the old text file from the tree.
    
    Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 Documentation/networking/ieee802154.txt | 177 --------------------------------
 1 file changed, 177 deletions(-)
