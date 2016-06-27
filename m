Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ipv4.connman.net ([82.165.8.211]:57772 "EHLO mail.holtmann.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751728AbcF0GK6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Mon, 27 Jun 2016 02:10:58 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH RESEND bluetooth-next 2/3] ieee802154: add netns support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160618084535.4699-2-aar@pengutronix.de>
Date: Mon, 27 Jun 2016 08:10:55 +0200
Content-Transfer-Encoding: 8BIT
Message-Id: <0B35DDEF-681B-4695-80B8-B63FE3888849@holtmann.org>
References: <20160618084535.4699-1-aar@pengutronix.de> <20160618084535.4699-2-aar@pengutronix.de>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, Nicolas Dichtel <nicolas.dichtel@6wind.com>

Hi Alex,

> This patch adds netns support for 802.15.4 subsystem. Most parts are
> copy&pasted from wireless subsystem, it has the identically userspace
> API.
> 
> Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Reviewed-by: Stefan Schmidt <stefan@osg.samsung.com>
> Signed-off-by: Alexander Aring <aar@pengutronix.de>
> ---
> include/net/cfg802154.h   | 13 +++++++++
> include/net/nl802154.h    |  5 ++++
> net/ieee802154/core.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
> net/ieee802154/core.h     |  2 ++
> net/ieee802154/nl802154.c | 54 ++++++++++++++++++++++++++++++++----
> 5 files changed, 138 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

