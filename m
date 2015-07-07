Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from senator.holtmann.net ([87.106.208.187]:52320 "EHLO
	mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755824AbbGGMPh (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Jul 2015 08:15:37 -0400
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH bluetooth-next 1/2] mac802154: do not export ieee802154_rx()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
Date: Tue, 7 Jul 2015 14:15:32 +0200
Content-Transfer-Encoding: 7bit
Message-Id: <F2B72C20-DF4A-446A-8D3D-DEA63CB2FE70@holtmann.org>
References: <1436246443-8243-1-git-send-email-varkabhadram@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Varka Bhadram <varkabhadram@gmail.com>
Cc: linux-wpan@vger.kernel.org, alex.aring@gmail.com

Hi Varka,

> Right now there are no other users for ieee802154_rx()
> in kernel. So lets remove EXPORT_SYMBOL() for this.
> 
> Also it moves the function prototype from global header
> file to local header file.
> 
> Signed-off-by: Varka Bhadram <varkabhadram@gmail.com>
> ---
> include/net/mac802154.h      |   17 -----------------
> net/mac802154/ieee802154_i.h |    1 +
> net/mac802154/rx.c           |    1 -
> 3 files changed, 1 insertion(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

