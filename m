Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:34369 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752908AbbETKL0 (ORCPT
	<rfc822;linux-wpan@vger.kernel.org>); Wed, 20 May 2015 06:11:26 -0400
Received: by wghq2 with SMTP id q2so47367219wgh.1
        for <linux-wpan@vger.kernel.org>; Wed, 20 May 2015 03:11:25 -0700 (PDT)
Date: Wed, 20 May 2015 12:11:20 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCH 8/8] mac802154: mac802154_mlme_start_req() optimisation.
Message-ID: <20150520101116.GC3978@omega>
References: <cover.1432064518.git.buytenh@wantstofly.org>
 <20150519195022.GT11014@wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20150519195022.GT11014@wantstofly.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: linux-wpan@vger.kernel.org

On Tue, May 19, 2015 at 10:50:22PM +0300, Lennert Buytenhek wrote:
> mac802154_mlme_start_req() calls
> ieee802154_mlme_ops(dev)->llsec->set_params() on the net_device
> passed into it, however, this net_device will always be a mac802154
> net_device, so just call mac802154_set_params() directly instead.
> 
> Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Acked-by: Alexander Aring <alex.aring@gmail.com>
