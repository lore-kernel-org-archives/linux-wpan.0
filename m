Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E9C0032E
	for <linux-wpan@archiver.kernel.org>; Thu, 26 Oct 2023 01:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZBEx (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Wed, 25 Oct 2023 21:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJZBEw (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Wed, 25 Oct 2023 21:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C5CA4
        for <linux-wpan@vger.kernel.org>; Wed, 25 Oct 2023 18:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698282247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F0jgtCoGKnOPdr5wAVA1jC6SOkxL9JrwQI7bHKSq9nA=;
        b=S6eXrrRff3ysIByd2fVxjtvaT3qb/ybmh3eiDyPn2V/O204Ghd+VVsQRLWoofb4w7sgo6E
        xqy7L0MJ2a3ldqfwb3gOCswdpfXCx//o6aa+m97JMvzD1A8tPBb3J2YoMTMZ+0Cq8mZzMZ
        9oYAja+m00cSma2ccDj7BHmICL/6nxo=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-2TTsSSZQOs---5sRDcl5Ig-1; Wed, 25 Oct 2023 21:03:50 -0400
X-MC-Unique: 2TTsSSZQOs---5sRDcl5Ig-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9ba247e03aeso19943466b.1
        for <linux-wpan@vger.kernel.org>; Wed, 25 Oct 2023 18:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698282229; x=1698887029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0jgtCoGKnOPdr5wAVA1jC6SOkxL9JrwQI7bHKSq9nA=;
        b=k87Ko3Uy86XGxOabvK+a8jWU4YmzStNptqpMrYyWs+ZCaWfbWmgWn5+9ZOPbh5ujHK
         UFA3r/BOG3cVlwwor6zyp+8kwQXHdLAnTnYMLjyLQLlQhSoPayKx7mmfcM86IlmBnDWu
         aht8TZsHwHHpJ8Sciwg7X7/e7Ch91KEKY5qv09CmyPRxznYBjgtm+CgJncRmS9J4mjuL
         DDvG4n7kcb6HOBvgRPitOBbfYuMgso7ht82RTijZlWnNdH8DMa3Ht36KMWIikBsBdnge
         hGZ9LF29tbsGWNBuSoOMfd3ezXPVut5urTw/Csye+JcQuiD1wlyPhetzrMGKH40HJcv3
         6FrA==
X-Gm-Message-State: AOJu0YxFNfBUKCkbS4CnQ4PsjkPS2RVLXLSF/6BsFO6twTAss2ObrfN5
        MWzwTJ/TMv3x87egZwHVfFBQcD/SBkvNOG/1HgXaVFhG2SRMk7OPga29hmIquO/PB9VsH6JQYLx
        JdEV2jKtc7Kaq8iikfI0PMQug2yDcZo2Pn2V6DKdEIYIbZN7R
X-Received: by 2002:a17:907:3fa2:b0:9ae:56da:6068 with SMTP id hr34-20020a1709073fa200b009ae56da6068mr13404807ejc.57.1698282228770;
        Wed, 25 Oct 2023 18:03:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGyO5sKrQwerChLyYP+FkF6J0ubwEz+CgdplpthydRvFwbqMeXmJ9CBL4iYSMh+4enIGV2GnsE0igPhr6iQg10=
X-Received: by 2002:a17:907:3fa2:b0:9ae:56da:6068 with SMTP id
 hr34-20020a1709073fa200b009ae56da6068mr13404788ejc.57.1698282228136; Wed, 25
 Oct 2023 18:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <d25926f8-84bd-4eef-9e44-86fb1e3e5932@silabs.com> <13794.1698248146@localhost>
In-Reply-To: <13794.1698248146@localhost>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Wed, 25 Oct 2023 21:03:36 -0400
Message-ID: <CAK-6q+jCpWpoaX5acNEdOv=CybGUXUzNJ6Saa-s7ADevi5LjSA@mail.gmail.com>
Subject: Re: RPL lwtunnel encapsulation
To:     Michael Richardson <mcr@sandelman.ca>
Cc:     Mathis Marion <mathis.marion@silabs.com>,
        linux-wpan@vger.kernel.org,
        =?UTF-8?B?SsOpcsO0bWUgUG91aWxsZXI=?= <jerome.pouiller@silabs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Michael,

On Wed, Oct 25, 2023 at 11:45=E2=80=AFAM Michael Richardson <mcr@sandelman.=
ca> wrote:
>
>
> Mathis Marion <mathis.marion@silabs.com> wrote:
>     > However, my observations suggest that it is actually not the case w=
hen
>     > forwarding packets. Instead, the IPv6 header of the packet is modif=
ied
>     > in a way which violates the IPv6 specification (RFC 8200 section 4)=
:
>
> I have not sat down to read the code to understand what it actually does,=
 so
> I can't really comment at this point.  I salute you for having gotten int=
o
> whether the code is compliant.
>
> But, I did write spend way too much of my life writing
>      https://datatracker.ietf.org/doc/rfc9008/
> to deal with the perception that RPL networks had to violate 8200.
>
> I know that Linux does not (yet) deal with all the minutia in 9008.
> I wish that I had time to fix that.

To put everything into IPIP and back is not a question of doing a
iptunnel ip6tnl [0] and doing the right configuration... just do get
everything over "the internet" which I think is the whole reason why
putting everything into IPIP?

- Alex

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/net/ipv6/ip6_tunnel.c

