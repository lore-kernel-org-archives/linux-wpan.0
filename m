Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:37754 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeGIVSE (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 9 Jul 2018 17:18:04 -0400
Received: by mail-it0-f65.google.com with SMTP id p17-v6so28405363itc.2
        for <linux-wpan@vger.kernel.org>; Mon, 09 Jul 2018 14:18:04 -0700 (PDT)
Date: Mon, 9 Jul 2018 17:17:54 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: [PATCH] ieee802154: add rx LQI from userspace
Message-ID: <20180709211754.v2oqe3y77fvdd5qa@x220t>
References: <20180607140802.22666-1-peron.clem@gmail.com>
 <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac0ff951-627d-9694-741d-03f6bc4d6ddc@datenfreihafen.org>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>, Romuald Cari <romuald.cari@devialet.com>, linux-wpan@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@osg.samsung.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?Q?Cl=C3=A9ment?= Peron <clement.peron@devialet.com>

On Mon, Jul 09, 2018 at 10:49:08AM +0200, Stefan Schmidt wrote:
> Hello Clement.
> 
> Finally coming to review the patch. Sorry for the delay.
....
> >  
> > +	if (ro->want_lqi) {
> > +		err = put_cmsg(msg, SOL_IEEE802154, WPAN_WANTLQI,
> > +			       sizeof(uint8_t), &(mac_cb(skb)->lqi));
> > +		if (err)
> > +			goto done;
> > +	}
> > +
> 
> I am wondering a bit about the LQI you get back here. Maybe Alex can
> also shed some lights on it. The LQI value stored here is always from
> the last frame send (to any peer)? Or is it the last frame send to this
> specific peer?
>

LQI is available only for per received frame [0], it's important to store
it always when address information are available for the received frame.
The peer you get from the socket layer so far I understood.

Storing means: maybe with some intelligent logic behind to calculate the
average... one LQI value alone don't say anything. With this patch you
can do such logic in user space as a LQI to peer database[1].

Otherwise we already talked about a similar handling as wireless does
with "iw ... station dump" to have such handling in kernel - out of
scope of this discussion.

Side notes:

[0] Ack frames has no address information but it refers to a transmitted
    frame with address information... so not always true. But ack
    handling is offloaded anyhow in the most cases.

[1] Getting complicated how to map a short/pan _and_ extended to _ONE_
    peer entry. -> MLME assoc()/IPv6 ndisc information are needed here.

- Alex
