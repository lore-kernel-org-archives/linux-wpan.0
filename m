Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36337 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbdEQQBf (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 17 May 2017 12:01:35 -0400
Received: by mail-wr0-f171.google.com with SMTP id l50so14363317wrc.3
        for <linux-wpan@vger.kernel.org>; Wed, 17 May 2017 09:01:34 -0700 (PDT)
Date: Wed, 17 May 2017 18:01:26 +0200
From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: monitor interfaces and fcs
Message-ID: <20170517160117.7xxiskohbtqiffex@omega>
References: <20170505201000.hprmmtwsfi6jy7uf@omega>
 <20887.1494505774@obiwan.sandelman.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20887.1494505774@obiwan.sandelman.ca>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hi,

On Thu, May 11, 2017 at 08:29:34AM -0400, Michael Richardson wrote:
> 
> Alexander Aring <alex.aring@gmail.com> wrote:
>     > New behaviour?:
> 
>     > The new behaviour should also deal with hardware where we don't get FCS
>     > information from hardware (cc2520 in non promicuousmode is such
>     > hardware).
> 
> Nice.
> 
>     > Important node - you can change this behaviour for monitors:
> 
>     > Rx: while monitor interface generation you can decide if you want FCS
> 
>     > Tx: while monitor interface generation you can decide if you want to
>     > send FCS
> 
> Do you return FCS as auxdata if asked for?
> 

What is auxdata in this case?

I need to explain the current issue again and I hope it's more clear.

On monitor interfaces as default handling (rx): The FCS is part of the
payload of recv(2) in case of AF_PACKET RAW sockets.

(tx) side: The FCS isn't part of payload, it should not - there is a bug
in wireshark which "thinks" there is a FCS, that's why every packet
will show a warning "FCS wrong".

NOW on node interfaces (default handling): 

On rx side it's not part of payload. So developed AF_PACKET RAW
applications will not work on monitors AND node, or you do a nl802154
check if you operate on monitor or node interface and cut the FCS right
in your recv(2) for parsing.

>     > If the hardware doesn't support that - it will not allow you to generate
>     > such interface.
> 
> Do you mean, if the hardware can't return FCS? Or insists on generating FCS
> itself?
> 

yes.

>     > IMPORTANT NOTE:
>     > This will of course break userspace software - fix should be simple, but
>     > it's already broken somehow. E.g. tx with wireshark, it thinks there is
>     > a FCS there, but there is no FCS...
> 
>     > We should fix all userspace software afterwards...
> 
>     > What we need is just some behaviour which everybody acks now and we
>     > don't touch it again! Please comment this mail with your opinions about
>     > default behaviours of FCS and different interface types (node vs
>     > monitor) in combination with AF_PACKET RAW.
> 
> It is unfortunate, but I think that the number of people doing monitoring
> on 15.4 is relatively small, and it's mostly with wireshark.
> Is there a way to determine old behaviour vs new behaviour?
> 

I think yes, I will introduce some flags and if nl802154 return with
"-EINVAL" it should indicate the old behaviour, then it should know on
monitor interfaces "there is a FCS".

These flags are:

FCS_RX
FCS_TX

when you create monitors you can set this flags and then you can send
FCS on TX/RX depends on which flags you set or even both.
Wireshark will read these flags and sets right bools for parsing FCS or
not and use small nl802154 implement, e.g. nl80211 [1].

At default - there are no FCS on tx and rx. Because I would recommend
such setup to do AF_PACKET RAW experiments. If you want to deal with FCS
then you need to know your setting or readout these flags in AF_PACKET
RAW application.

Does this sounds okay? :-/ Or should the default on monitors to have FCS
in payload for RX/TX. But then many people hit issues e.g. generating
monitors where the hardware doesn't support such handling AND AF_PACKET
RAW sockets which was made for node interfaces only. I think... it
should drop the FCS for avoid fails of users, but for experts... you
will enable read FCS (e.g. for sniffing).

---
Things are in the reality even more complicated:

Because we have also a monitor interface type as net-core define type [0],
which was wrong to introduce such define (in my opinion). We should
handle it like wireless that the types(L2 roles) are known by nl802154 only.
It's part of UAPI and we will never remove it again...

Anyway I would move to flags to make every possible setting working.

- Alex

[0] http://elixir.free-electrons.com/linux/latest/source/include/uapi/linux/if_arp.h#L90
[1] https://github.com/wireshark/wireshark/blob/2832f4e97d77324b4e46aac40dae0ce898ae559d/caputils/ws80211_utils.c
