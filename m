Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:48673 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753279AbbFXN1s (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 24 Jun 2015 09:27:48 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next 1/3] mac802154: util: add stop_device utility function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435138596-25909-1-git-send-email-alex.aring@gmail.com>
Date: Wed, 24 Jun 2015 15:27:41 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <97B7DF66-2BB4-4D32-8004-E238392B3278@holtmann.org>
References: <1435138596-25909-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de, varkab@cdac.in

Hi Alex,

> This patch adds ieee802154_stop_device for preparing a utility function
> to stop the ieee802154 device.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/mac802154/ieee802154_i.h | 1 +
> net/mac802154/iface.c        | 7 ++-----
> net/mac802154/util.c         | 8 ++++++++
> 3 files changed, 11 insertions(+), 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

