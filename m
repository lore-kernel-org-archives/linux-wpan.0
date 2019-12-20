Return-Path: <SRS0=/weu=2K=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92223C43603
	for <linux-wpan@archiver.kernel.org>; Fri, 20 Dec 2019 22:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51F9A206DA
	for <linux-wpan@archiver.kernel.org>; Fri, 20 Dec 2019 22:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm4jvguo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfLTWwd (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 20 Dec 2019 17:52:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38597 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfLTWwd (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 20 Dec 2019 17:52:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id d7so9362891otf.5
        for <linux-wpan@vger.kernel.org>; Fri, 20 Dec 2019 14:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t/Ab5M8EhSP9EwQUbWSjA8eeoPkE4tsydjtQX/nzHqM=;
        b=dm4jvguokl0dVpRLQb1o/a3I4OTjpavQI/W47EIGKEL/MG9Op0n3a/pbBWHk2EpOSw
         Bp9sBJjQyc37P3ZOHkK5jA3YKOjLq7UG2gtpqT4fDTUfgNUKMwJblikzHVGcCbXn6sJX
         dCj18gypGna6rocBH7iIU62C4SkVUhEl/BieQo+llzgoEHmX36VSqTG1/fGeZ3tWD9lQ
         VjddVSv92QKmedw1OHSWqJwIlBE8GvZ6ippPGBSvptRdfgDcDwvvR4EtHixQfsiKQy4e
         MCVrhQO6zUdVHHo9OLpi6NkUlk7D/eHH5egPqgnDzL7qKZePKazlZiOnAuO3feWLlS+H
         V6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t/Ab5M8EhSP9EwQUbWSjA8eeoPkE4tsydjtQX/nzHqM=;
        b=SzM3FQv/pkTfsqYl4dE9uK0Kzw7C7cuG99POz4JJjABwg6C1huDAw+21unTsRjXWUu
         VLoQczLNU38Ofbr8AEA9qiqWfEX+OTqAMM8aMVGHveW93FMQqWo2Wg3mRTFL+Q/YY0VS
         oogns0SYXP415RHPhu57UvyfqX6MuZ3nL/+QimlpEG2HJnoCnThNtkgROxOOVk0EoibU
         /Z/l1FzCamDchLaUOfu7uv/J2kOMBQVxtLpafLCki/THIFrJb+UeLv/M6/TMU/HxZz1t
         hvLxPuL+Y9mgpJdwoB42rBJt9+wMQ6fZIdHbS3jt9AketY+h31Y9PRTMydN9bwP3zxve
         wD2Q==
X-Gm-Message-State: APjAAAUDKVLRvf5VjdxNAkb8yMGfpNGAnU1oyvtFwU8oQrnu4PLlXxO3
        vxMQ+m/ZHHkKWh/fRA9uQUa/Ro+baQzseSZykI2bPthh
X-Google-Smtp-Source: APXvYqy0rHbeSYzyrMfnGPkCFBoqrsF2HzNq9wWirwN1U5ahmIgKmf90AcPMm1Qs6IiIS7rAsKQXrYWy39wRHADCiyo=
X-Received: by 2002:a9d:6d81:: with SMTP id x1mr18337341otp.9.1576882352711;
 Fri, 20 Dec 2019 14:52:32 -0800 (PST)
MIME-Version: 1.0
References: <20190918195819.7492-1-stefan@datenfreihafen.org> <20190918195819.7492-3-stefan@datenfreihafen.org>
In-Reply-To: <20190918195819.7492-3-stefan@datenfreihafen.org>
From:   Alexander Aring <alex.aring@gmail.com>
Date:   Fri, 20 Dec 2019 17:52:21 -0500
Message-ID: <CAB_54W7a8gsqWsSf-V9DjbhmKvqhwCVRu2z6dWDOSR3mp5zLLw@mail.gmail.com>
Subject: Re: [PATCH rpld 2/6] send: make sure we check on scope id usage
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi Stefan,,

On Wed, 18 Sep 2019 at 15:58, Stefan Schmidt <stefan@datenfreihafen.org> wrote:
>
> It fails on my machine and likely fails on others, better
> check for it.
> ---
>  send.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/send.c b/send.c
> index 97c566d..d026f6a 100644
> --- a/send.c
> +++ b/send.c
> @@ -53,11 +53,9 @@ static int really_send(int sock, const struct iface *iface,
>         pkt_info->ipi6_ifindex = iface->ifindex;
>         memcpy(&pkt_info->ipi6_addr, iface->ifaddr_src, sizeof(struct in6_addr));
>
> -#if 1
> -//#ifdef HAVE_SIN6_SCOPE_ID
> +#ifdef HAVE_SIN6_SCOPE_ID

This HAVE_ stuff is from autoconf where I took the code (radvd), so
this will mostly end in #ifdef 0 because we use meson now and don't
ask me how to check on this in meson but it's simple I think. :-)
I think we can remove this code and see if we break something. The
point here radvd is ported to BSD, Linux, etc. and this is some system
thing. _Maybe_ it is really not necessary for Linux systems _because_
we set above "pkt_info->ipi6_ifindex = iface->ifindex;" which is maybe
enough on a Linux system... but it could also be to solve some UAPI
messup.... just remove it. In a scope of link-local we must set the
interface somehow, I am not sure how the correct API works here, as I
said... look if it makes problems. Sorry but it means: I am too lazy
too look it up why this is necessary in radvd (git blame is maybe
enough?).

Note: That it compiles on my Linux machine and not on your Linux
machine, means there is something in Linux API headers.

- Alex
