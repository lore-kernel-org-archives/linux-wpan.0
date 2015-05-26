Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34977 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbbEZSRU (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Tue, 26 May 2015 14:17:20 -0400
Received: by wicmx19 with SMTP id mx19so86242967wic.0
        for <linux-wpan@vger.kernel.org>; Tue, 26 May 2015 11:17:19 -0700 (PDT)
Date: Tue, 26 May 2015 20:17:14 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv2 bluetooth-next 6/6] mac802154:
 mac802154_mlme_start_req() optimisation.
Message-ID: <20150526181712.GA2954@omega>
References: <cover.1432535597.git.buytenh@wantstofly.org>
 <20150525123851.GO11340@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150525123851.GO11340@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Mon, May 25, 2015 at 03:38:51PM +0300, Lennert Buytenhek wrote:
> mac802154_mlme_start_req() calls
> ieee802154_mlme_ops(dev)->llsec->set_params() on the net_device
> passed into it, however, this net_device will always be a mac802154
> net_device, so just call mac802154_set_params() directly instead.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>

