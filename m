Return-Path: <SRS0=HUoy=Y6=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4804C5DF63
	for <linux-wpan@archiver.kernel.org>; Wed,  6 Nov 2019 14:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943332178F
	for <linux-wpan@archiver.kernel.org>; Wed,  6 Nov 2019 14:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U2lkXbzB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbfKFOCm (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 6 Nov 2019 09:02:42 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:43102 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFOCl (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 6 Nov 2019 09:02:41 -0500
Received: by mail-ot1-f44.google.com with SMTP id l14so6566596oti.10
        for <linux-wpan@vger.kernel.org>; Wed, 06 Nov 2019 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4hBf2d+cbZe8LUmEpfQ+ojId9W2RflXwy7EJcWveYnc=;
        b=U2lkXbzBE/OvZiW///eIfHRaWd29plEHhewWiCU9Ko9elKQOzhhJm33pc0deoLgLBf
         5vbUNuMkkKPglFFeGswJCgxOMwZLtY0KyNq8pA5+7XeCw5K4imnsxrNIyfXXevs3aGAz
         ylQ5DtHmbMS61s15jKX2icV4RIAlae6Y3Rv87GA94HARwy0RD2q8VrzwJFO/EUErcRiD
         O4G+DMf7Z3gjWDQqnRuKGpMtQoadS2MdhVWtmSK85RLy95cijTr6JkV4I7nNVVHSlwSc
         xL7jc8Ao9k27IKaIm8oaHTjXFmmmOwI5YCbFAEY8WZpdNDJaVztjsvW6ir8UN4abFCsR
         1vjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4hBf2d+cbZe8LUmEpfQ+ojId9W2RflXwy7EJcWveYnc=;
        b=lZlQjp2cRaE5HwTNw/gpggQAuvxffdVdI3Utzla7/zgB1yjCQck2gWHG+Iaoz8zh/l
         iGjR+EkiZ9mS4qKMbM3ITyoiPfHEkSFITsFRFnVfuaoHSTtUTsubeIu+/sZg/ISmRl3K
         Z+qNbV9jLxDm2Flg+fZPXBjV0r3r55TQZXVyYBQ7vpzkvAp1WfQw8/kIyycD5gJh2ojw
         K3hEs8wngZLOB+Bfkz7QfTdsdRj/QX1ZUiRFaIs9VQ0MaghLs/xF/QbJ2qxwswyK9O5H
         k6+A0n7xbjPYuRxowot1eBxRZTQ+0fdglHvGAdUlUMZ+imd1EZnd3WOMlh1JuP7FeDgW
         2VXg==
X-Gm-Message-State: APjAAAUEMJIs0FhKbUU53TsPoTmpUJKBnHscSvO03JbDsdxq/NpVFcdp
        FJrWQ5aMBJLTZM6UcmYvWluKFXwh8Jy6mzWS2dU=
X-Google-Smtp-Source: APXvYqwPmKpy0OPPp4j2NDOhI2us/M84lIS4WT2CVrQ1Id75SxHOylW/Oo5vPV3Iv2okUz1k+ermjPHdKDQG6qQTXBg=
X-Received: by 2002:a9d:37e6:: with SMTP id x93mr2010027otb.183.1573048956225;
 Wed, 06 Nov 2019 06:02:36 -0800 (PST)
MIME-Version: 1.0
References: <547191739.3620092.1572042009933.JavaMail.zimbra@ufpe.br>
In-Reply-To: <547191739.3620092.1572042009933.JavaMail.zimbra@ufpe.br>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Wed, 6 Nov 2019 09:02:24 -0500
Message-ID: <CAB_54W5B+bjAHQU-JYbg34=F5c0HMV9q30uPPtopHqNhNChO8A@mail.gmail.com>
Subject: Re: Interfacing mac802154 stack with userspace applications
To:     Victhor Foster <victhor.foster@ufpe.br>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Victhor,

On Fri, Oct 25, 2019 at 6:39 PM Victhor Foster <victhor.foster@ufpe.br> wro=
te:
>
> Hello,
>
> I'm working on a project to implement a 6LoWPAN network using software de=
fined radios. I'm trying to interface the kernel's 802.15.4/6LoWPAN stacks =
to my physical layer implemented in GNU Radio, instead of using a userspace=
 stack, but this isn't working very well.
>
> The reason why I'm doing this is, while the GNU Radio plugin I'm using (g=
r-ieee802-15-4 from Bastian Bloessl) implements its own 802.15.4 MAC layer,=
 I'd like to get around its limitations (such as not being able to change d=
estination addresses at runtime) using the Linux kernel stack.
>

It's possible to change the destination address. Do you use af802154?

> The way this is being done is I have socat piping between a mac802154_hws=
im interface and GNU Radio, using the following arguments: INTERFACE:wpan0 =
UDP4-DATAGRAM:127.0.0.1:<port>
> GNU Radio is running a UDP server at <port> that transmits and receives P=
DUs to/from the software defined PHY, which then goes out to a software def=
ined radio device (a USRP N210, in this case). So the PDUs are sent via the=
 socat pipe to the hwsim network interface and vice-versa. The 802.15.4 MAC=
 block is removed.
>
> While 802.15.4 packets are sent and received by both hosts, it seems thes=
e packets aren't getting through to the 6LoWPAN stack.
>
Mhh, do you can provide more information about the setup so I can test
it on my own? Do you took care about channel/page and panid settings?


> During testing, I had packet capture set up on both the 802.15.4 ("wpan0"=
) and the 6LoWPAN ("lowpan0") interfaces. The wpan0 interface was receiving=
 packets from the other host (and also from itself, as the radio is full du=
plex), as expected. However, I could not get wpan-ping to work (timeout) an=
d ping6, netcat, etc. wouldn't get a response from the other host.
> On the lowpan0 interface, I could see the packets originating from applic=
ations would appear on the packet capture log, but those that should be com=
ing from the wpan0 interface wouldn't, even those originating from the host=
 itself (due to the full duplex nature of the radio).
>

No idea, this is now your gnuradio device?

> I also noticed the following message on the kernel log: ieee802154 phy0 w=
pan0: encryption failed: -22
> I haven't touched the link encryption settings, so the traffic is unencry=
pted.

This looks that you receive encrypted frames, it might be only the
frame control field is misleading and security is enabled, can you
check?

>
> What could be done to get the 6LoWPAN stack to accept packets injected in=
to the 802.15.4 interface by socat? I realize this is a very unusual situat=
ion, but I'm not familiar with the Linux 802.15.4 stack.

No idea, sorry for my late reply. Can you provide more information?

- Alex
