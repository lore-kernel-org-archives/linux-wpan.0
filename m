Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:38575 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbaLSXPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 19 Dec 2014 18:15:15 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCHv2 bluetooth-next 0/2] mac802154: iface: better concurrent iface handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419029159-21554-1-git-send-email-alex.aring@gmail.com>
Date: Sat, 20 Dec 2014 00:15:10 +0100
Content-Transfer-Encoding: 8BIT
Message-Id: <337AA17F-6261-48CC-95FC-32FAFF0EB8E5@holtmann.org>
References: <1419029159-21554-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de

Hi Alex,

> This patch series contains changes for a better multiple iface handling.
> We have only one phy with several mac parameters like csma, aret, etc.
> Currently it could be that one interface can overwrite these parameters
> while ifup when another interface is currently running. To avoid that
> we compare each parameter and check if differs, if not we allow to ifup
> the interface.
> 
> changes since v2:
> - fix mixed comments and variable declaration.
> 
> Alexander Aring (2):
>  mac802154: iface: check concurrent ifaces
>  ieee802154: iface: move multiple node type check
> 
> net/mac802154/iface.c | 100 +++++++++++++++++++++++++++++++++++++++++++-------
> 1 file changed, 86 insertions(+), 14 deletions(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

