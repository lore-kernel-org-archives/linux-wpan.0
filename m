Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:33238 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752377AbbACAuO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 2 Jan 2015 19:50:14 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next 0/6] ieee802154: kconfig entries and socket handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 2 Jan 2015 16:50:10 -0800
Content-Transfer-Encoding: 8BIT
Message-Id: <B49116CA-F068-4B9B-AF44-9502A1605CE3@holtmann.org>
References: <1420051153-8673-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> this patch series contains some cleanups to put all related socket handling
> functionality into one file. Also updates the Kconfig menu entries to
> preparing a movement out of "Networking Options".
> 
> The last series contains patches to create an af802154 subdirectory. I removed
> this way and but all things of af802154 (socket handling) into one file.
> After this series I will send the still the 6lowpan changes to put it into
> a 6lowpan subdirectory.
> 
> - Alex
> 
> Alexander Aring (6):
>  ieee802154: handle socket functionality as module
>  ieee802154: socket: change module name
>  ieee802154: socket: put handling into one file
>  ieee802154: socket: fix checkpatch issue
>  ieee802154: rename af_ieee802154.c to socket.c
>  ieee802154: handle config as menuconfig
> 
> net/ieee802154/Kconfig         |   16 +-
> net/ieee802154/Makefile        |    5 +-
> net/ieee802154/af802154.h      |   33 --
> net/ieee802154/af_ieee802154.c |  369 -------------
> net/ieee802154/dgram.c         |  549 --------------------
> net/ieee802154/raw.c           |  270 ----------
> net/ieee802154/socket.c        | 1125 ++++++++++++++++++++++++++++++++++++++++
> 7 files changed, 1142 insertions(+), 1225 deletions(-)
> delete mode 100644 net/ieee802154/af802154.h
> delete mode 100644 net/ieee802154/af_ieee802154.c
> delete mode 100644 net/ieee802154/dgram.c
> delete mode 100644 net/ieee802154/raw.c
> create mode 100644 net/ieee802154/socket.c

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

