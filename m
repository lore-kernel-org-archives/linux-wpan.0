Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it1-f195.google.com ([209.85.166.195]:51565 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbeLKPXw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 11 Dec 2018 10:23:52 -0500
Received: by mail-it1-f195.google.com with SMTP id x19so4099285itl.1
        for <linux-wpan@vger.kernel.org>; Tue, 11 Dec 2018 07:23:52 -0800 (PST)
Date: Tue, 11 Dec 2018 10:23:45 -0500
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH net-next] ieee802154: ca8210: fix possible u8 overflow in
 ca8210_rx_done
Message-ID: <20181211152345.gdlu6rnzng3kddgo@x220t>
References: <20181211031339.21048-1-yuehaibing@huawei.com>
 <20181210.220107.751606140724107779.davem@davemloft.net>
 <87dbac94-8b2e-8cef-5166-8c130529ceb9@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87dbac94-8b2e-8cef-5166-8c130529ceb9@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: David Miller <davem@davemloft.net>, yuehaibing@huawei.com, h.morris@cascoda.com, alex.aring@gmail.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-wpan@vger.kernel.org

Hi Stefan,

On Tue, Dec 11, 2018 at 09:26:37AM +0100, Stefan Schmidt wrote:
> Hello Dave.
> 
> On 11.12.18 07:01, David Miller wrote:
> > From: YueHaibing <yuehaibing@huawei.com>
> > Date: Tue, 11 Dec 2018 11:13:39 +0800
> > 
> >> gcc warning this:
> >>
> >> drivers/net/ieee802154/ca8210.c:730:10: warning:
> >>  comparison is always false due to limited range of data type [-Wtype-limits]
> >>
> >> 'len' is u8 type, we get it from buf[1] adding 2, which can overflow.
> >> This patch change the type of 'len' to unsigned int to avoid this,also fix
> >> the gcc warning.
> >>
> >> Fixes: ded845a781a5 ("ieee802154: Add CA8210 IEEE 802.15.4 device driver")
> >> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > 
> > WPAN maintainers, I am assuming that as maintainers you will be
> > picking this up and sending it to me.
> 
> That's correct. On driver patches I always wait 2 days or so to give the
> driver maintainer a chance to reply before I go ahead and apply it.
> 
> I will take this one directly now and do some smoke testing. It will
> come together with another fix as pull request to you.
>

If this "len" is related to the frame (error message says packet) length when
"rx_done()" what the function name tells me, I think what the drivers
is looking for is:

ieee802154_is_valid_psdu_len() plus maybe before calculation of the length
depends what else the transceiver put as payload.

side note:

All drivers need to check if the length is valid as this is transmitted
in the PHY header and even not portected by CRC which is only for the
MAC payload. I had some ugly bufferoverflows expierence with some
at86rf2xx while my microwave was on.

- Alex
