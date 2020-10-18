Return-Path: <SRS0=f8AC=DZ=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A4C433E7
	for <linux-wpan@archiver.kernel.org>; Sun, 18 Oct 2020 23:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7310522275
	for <linux-wpan@archiver.kernel.org>; Sun, 18 Oct 2020 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbLHiMmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgJRXVF (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 18 Oct 2020 19:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgJRXVF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 18 Oct 2020 19:21:05 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99202C061755
        for <linux-wpan@vger.kernel.org>; Sun, 18 Oct 2020 16:21:05 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i12so8754687ota.5
        for <linux-wpan@vger.kernel.org>; Sun, 18 Oct 2020 16:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2kfLteUIwExuv/yfta+bFTQO0lWy0FxvQfv/Bxv0vlY=;
        b=AbLHiMmHe8z74cumAFemNNgAMaJINSnSs4j87eRCMCspMN6S3fMxCGz/2oUihzMVMr
         7Cn+BYrMXceVKSkbVctke0Q0cBhxvIcez0LNkrKM3dQwVGcAH87jPJrTtm0DSuEWmMug
         PT6og6sHV6cnJFeiQY4NzWzlbA/we5zocC5KSoNTi3+CZXsS2irAVjw7RTCge6fVu9Yg
         AhA2EX9D525FR/QMpod+WbPNMvoNH5pkbSxdqEhgvpSZffRA9io7FOt/ON/ap0PlOW9S
         cBN4WF/MEp46sJBnLQBxvdSCAA9Tvo3vmwERVWVdNqh4G4DqDn3d7dN0x1kiSHlSH29H
         +CQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2kfLteUIwExuv/yfta+bFTQO0lWy0FxvQfv/Bxv0vlY=;
        b=WVDypp2xJQPGTzSQ+kIav2m8E2Qh/YvalZUgYza1OQVVB6My02CVvUvCuiITz//3ng
         6Tu9gfIi59avIJkLWzMf5iua2l5zkcaCRXIbswCTG9Y3hgXgRhyqbIa07jvFmsRxBmRZ
         qP8WUWEHCOKxLZcmVf82nwZo8v7F7lcx1pnlF4vboeGboejpOUSeMBqp8mWTmGmXe9d1
         MYuy4k6SbBx/V7o5fygUoX07Xc7hnnJvkY9/Z9n/syzNwPsC0e+VSTWgfQ9m1sNAgnxV
         BXxImnYIemEIvYMPEmqmnmXQZl6oEjhiC5IkbTrVQuWue2PeOPZl4ZXV9O2e2t8WvgG3
         N40g==
X-Gm-Message-State: AOAM532bEwbS6tVqPXzDHx6pk2cvhyk5Ga2epBbzxr7exOw+p0Ve+Yj9
        bFKTsBgyzfF+mGHOBEuczb1ttmaVcBh/FhIQ+WlwAwXHM4A=
X-Google-Smtp-Source: ABdhPJwLcGgTEDAiOQ4p5bqQsbxiIAkA3Zq43q5d2eYLsyWNorRp3wAOkLALB/pV6QEND+arRHUsEsEkHKusLi9vSAs=
X-Received: by 2002:a9d:2c05:: with SMTP id f5mr10341326otb.183.1603063264835;
 Sun, 18 Oct 2020 16:21:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201018170934.2c03c9e3@rechenknecht2k11>
In-Reply-To: <20201018170934.2c03c9e3@rechenknecht2k11>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Sun, 18 Oct 2020 19:20:53 -0400
Message-ID: <CAB_54W5VgY+DeqdjiQ7BJsmXw-G=POwGE7tzYuwAwYixe6y9XQ@mail.gmail.com>
Subject: Re: iwpan with LLSEC - attribute type 1 has an invalid length
To:     Benjamin Valentin <benjamin.valentin@ml-pa.com>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>, koen@bergzand.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sun, 18 Oct 2020 at 11:48, Benjamin Valentin
<benjamin.valentin@ml-pa.com> wrote:
>
> Hi,
>
> I'm trying to use the Linux WPAN stack with link-layer security.
> I checked out the nl802154_llsec branch of wpan-tools and enabled the
> IEEE802154_NL802154_EXPERIMENTAL config option.
>
> I followed the steps outlined in [0], but configuring the seclevel
> would always fail with
>
> > netlink: 'iwpan': attribute type 1 has an invalid length.
>
> in dmesg.
> I followed the commands from the GitHub wiki:
>
> KEY="c0:c1:c2:c3:c4:c5:c6:c7:c8:c9:ca:cb:cc:cd:ce:cf"
> WPAN=wpan0
>
> PANID=$(iwpan     dev $WPAN info | grep pan_id        | head -1 | awk '{print $2}')
> SHORTADDR=$(iwpan dev $WPAN info | grep short_addr    | head -1 | awk '{print $2}')
> EXTADDR=$(iwpan   dev $WPAN info | grep extended_addr | head -1 | awk '{print $2}')
>
> iwpan dev $WPAN set security 1 # works fine
> iwpan dev --debug $WPAN key add 2 $KEY 0 $PANID 3 $EXTADDR # works fine
>
> -- Debug: Sent Message:
> --------------------------   BEGIN NETLINK MESSAGE ---------------------------
>   [NETLINK HEADER] 16 octets
>     .nlmsg_len = 112
>     .type = 24 <0x18>
>     .flags = 5 <REQUEST,ACK>
>     .seq = 1603033315
>     .port = 1971323733
>   [GENERIC NETLINK HEADER] 4 octets
>     .cmd = 23
>     .version = 0
>     .unused = 0
>   [PAYLOAD] 92 octets
>     08 00 03 00 03 00 00 00 54 00 25 00 05 00 02 00 ........T.%.....
>     02 00 00 00 14 00 04 00 c0 c1 c2 c3 c4 c5 c6 c7 ................
>     c8 c9 ca cb cc cd ce cf 34 00 01 00 28 00 03 00 ........4...(...
>     06 00 01 00 23 00 00 00 08 00 02 00 03 00 00 00 ....#...........
>     06 00 03 00 00 ab 00 00 0c 00 04 00 8f d7 0c a1 ................
>     9c 41 04 92 08 00 01 00 00 00 00 00             .A..........
> ---------------------------  END NETLINK MESSAGE   ---------------------------
> -- Debug: Received Message:
> --------------------------   BEGIN NETLINK MESSAGE ---------------------------
>   [NETLINK HEADER] 16 octets
>     .nlmsg_len = 36
>     .type = 2 <ERROR>
>     .flags = 256 <ROOT>
>     .seq = 1603033315
>     .port = 1971323733
>   [ERRORMSG] 20 octets
>     .error = 0 "Success"
>   [ORIGINAL MESSAGE] 16 octets
>     .nlmsg_len = 16
>     .type = 24 <0x18>
>     .flags = 5 <REQUEST,ACK>
>     .seq = 1603033315
>     .port = 1971323733
> ---------------------------  END NETLINK MESSAGE   ---------------------------
>
> iwpan --debug dev $WPAN seclevel add 0xff 2 0 # dmesg says attribute type 1 has an invalid length.
>

2 is ack frame, I think you mean 1.

> -- Debug: Sent Message:
> --------------------------   BEGIN NETLINK MESSAGE ---------------------------
>   [NETLINK HEADER] 16 octets
>     .nlmsg_len = 56
>     .type = 24 <0x18>
>     .flags = 5 <REQUEST,ACK>
>     .seq = 1603033355
>     .port = 1535116138
>   [GENERIC NETLINK HEADER] 4 octets
>     .cmd = 32
>     .version = 0
>     .unused = 0
>   [PAYLOAD] 36 octets
>     08 00 03 00 03 00 00 00 1c 00 22 00 08 00 01 00 ..........".....
>     ff 00 00 00 08 00 02 00 02 00 00 00 05 00 04 00 ................
>     00 00 00 00                                     ....
> ---------------------------  END NETLINK MESSAGE   ---------------------------
> -- Debug: Received Message:
> --------------------------   BEGIN NETLINK MESSAGE ---------------------------
>   [NETLINK HEADER] 16 octets
>     .nlmsg_len = 36
>     .type = 2 <ERROR>
>     .flags = 256 <ROOT>
>     .seq = 1603033355
>     .port = 1535116138
>   [ERRORMSG] 20 octets
>     .error = 0 "Success"

Success? Like above? Can you tell me the command line error message
please? What does tell you "type 1 has an invalid length"

>   [ORIGINAL MESSAGE] 16 octets
>     .nlmsg_len = 16
>     .type = 24 <0x18>
>     .flags = 5 <REQUEST,ACK>
>     .seq = 1603033355
>     .port = 1535116138
> ---------------------------  END NETLINK MESSAGE ---------------------------
>
> I then continue with
>
> iwpan dev $WPAN device add 0 $PANID $SHORTADDR $EXTADDR 0 0
> iwpan dev $WPAN set out_level 0x05
> iwpan dev $WPAN set out_key_id 0 $PANID 2 $SHORTADDR 3 $EXTADDR
>
> But I can not receive encrypted frames nor can I send any - instead I get
>
> [  502.970528] ieee802154 phy0 wpan0: encryption failed: -126
> [  503.972415] ieee802154 phy0 wpan0: encryption failed: -126
>

It tells you -ENOKEY, the whole thing has an ACL and somehow the
lookup cannot find a key (if sec is enabled).

> in dmesg.
>
> iwpan dev wpan0 info gives:
>
> Interface wpan0
>         ifindex 3
>         wpan_dev 0x1
>         extended_addr 0x9204419ca10cd78f
>         short_addr 0xffff
>         pan_id 0x0023
>         type node
>         max_frame_retries 3
>         min_be 3
>         max_be 5
>         max_csma_backoffs 4
>         lbt 0
>         ackreq_default 0
>         security 1
>         out_level 5
>         out_key_id
>                 mode implicit
>                 pan_id 0x0023
>                 addr_mode 2
>                 short_addr 0xffff
>         frame_counter 0x00000000
>
> Is LLSEC broken or am I configuring it wrong?

It's been a long time since I worked with it, it's good to have the
802.15.4 standard right beside you, the implementation is very close
to that structure that they describe.

There are known issues:

 - Don't trust wireshark, you will not see exactly what's sending out
on the wire. We just do the encryption on the wrong layer, but moving
it was causing other problems. I recently stumbled over something
which maybe can help us there, but didn't look closely at that, some
subsystems have special handling for tcpdump/wireshark things.
 - The frame_counter thing that you see above needs to be synchronized
on all nodes, if nodes join with a zero value you can do replay
attacks. 802.15.4 doesn't solve that on the link layer for peer to
peer, MLE can do that in a way to just make the attack window smaller.
 - When the fame_counter overflows you need a new key, means key
management and key exchange. Biggest problem :-) I was talking with
Koen about that once... he showed me some interesting stuff, forgot
the name..

Please dump more:

iwpan dev $WPAN_DEV seclevel dump
iwpan dev $WPAN_DEV device dump
iwpan dev $WPAN_DEV devkey dump
iwpan dev $WPAN_DEV key dump

- Alex
