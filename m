Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:47266 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932796AbbFLJod (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Fri, 12 Jun 2015 05:44:33 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH bluetooth-next] mac802154: fix flags BIT definitions order
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434093840-27138-1-git-send-email-alex.aring@gmail.com>
Date: Fri, 12 Jun 2015 11:44:31 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <1086E824-4EDA-4C10-A1B4-792A36584875@holtmann.org>
References: <1434093840-27138-1-git-send-email-alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <alex.aring@gmail.com>
Cc: linux-wpan@vger.kernel.org

H Alex,

> This patch fixes commits ("mac802154: cleanup ieee802154 hardware flags")
> bcbfd2078d9b11277d9c9ce0c30ba73c750503c9 and ("mac802154: cleanup address
> filtering flags") 6b70a43c7e0202cf285c864bc9f20f607c42e432 by starting
> the flags definitions at BIT(0) which is same like the previous behaviour.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> include/net/mac802154.h | 24 ++++++++++++------------
> 1 file changed, 12 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

