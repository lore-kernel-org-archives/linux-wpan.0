Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:52713 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161037AbbE2NmD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 29 May 2015 09:42:03 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCHv2 bluetooth-next 0/4] Atusb driver improvements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Date: Fri, 29 May 2015 15:41:50 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <F7D32BA7-A9DC-41A9-886A-EF1F0C91C148@holtmann.org>
References: <1432889488-28420-1-git-send-email-stefan@osg.samsung.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@osg.samsung.com>
Cc: linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>

Hi Stefan,

> Some patches to let the atusb driver catchup a bit with newer stack features.
> Namely we now support tx power and promiscuous mode setting. The first patch
> adds some infrastructure for this by adding a function to write parts of a
> register.
> 
> The last patch adds me as the maintainer for the driver. Alex suggested that
> I should do this and as I have the device, working on the firmware as well
> and are motivated to enhance it I think its a good idea.
> 
> Changes in v2:
> 	Fix checkpatch complains pointed out by Varka Bhadram
> 
> Stefan Schmidt (4):
>  ieee802154/atusb: Add function for partial register writes
>  ieee802154/atusb: Add .set_txpower operation to the driver
>  ieee802154/atusb: Add .set_promiscuous_mode driver operation
>  MAINTAINERS: Add myself as maintainer for the atusb driver
> 
> MAINTAINERS                    |   8 ++++
> drivers/net/ieee802154/atusb.c | 101 +++++++++++++++++++++++++++++++++--------
> 2 files changed, 90 insertions(+), 19 deletions(-)

all 4 patches have been applied to bluetooth-next tree.

Regards

Marcel

