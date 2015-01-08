Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:45737 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104AbbAHOtb (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Thu, 8 Jan 2015 09:49:31 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH bluetooth-next] ieee802154: 6lowpan: fix Makefile entry
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420713010-16105-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 8 Jan 2015 06:49:26 -0800
Content-Transfer-Encoding: 7bit
Message-Id: <236E6085-F9DC-47B7-9344-0DDDBD8D79F9@holtmann.org>
References: <1420713010-16105-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

H Alex,

> Since commit ea81ac2e7050798109356150ea16e71622a5c329 ("ieee802154:
> create 6lowpan sub-directory") we have a subdirectory for the ieee802154
> 6lowpan implementation. This commit also moves the Kconfig entry inside
> of net/ieee802154/6lowpan/ and forgot to rename the Makefile entry from
> obj-$(CONFIG_IEEE802154_6LOWPAN) to obj-y and handle the
> obj-$(CONFIG_IEEE802154_6LOWPAN) inside the created 6lowpan directory.
> This will occur that the ieee802154_6lowpan can't be build.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/ieee802154/6lowpan/Makefile | 2 +-
> net/ieee802154/Makefile         | 2 +-
> 2 files changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

