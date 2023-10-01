Return-Path: <linux-wpan-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8725E7849C
	for <linux-wpan@archiver.kernel.org>; Sun,  1 Oct 2023 23:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJAXiY (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sun, 1 Oct 2023 19:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjJAXiX (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sun, 1 Oct 2023 19:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B12BD
        for <linux-wpan@vger.kernel.org>; Sun,  1 Oct 2023 16:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696203454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzzDJ/20k7un6ytFcQ3c+5NSkerSAlV3eQJ3FMdrkuI=;
        b=dVct9zhXr6DOAmJve32e91ejLzsyi2Si0jzmpAbmj7sL26N7/brsMgdWk8AuL1b8PYESSc
        nTlgQJT0HwR3HWOCMI2gHHzRdQd4sE5XNpqkI1lTo7AX1PLPT3k3xskH2svq4fE+C+BJRU
        1LeOIPll0QjG5YWzOAPua5H72NDYpYc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-249-MNjQe9HKNC2Pk1SkN10y3g-1; Sun, 01 Oct 2023 19:37:31 -0400
X-MC-Unique: MNjQe9HKNC2Pk1SkN10y3g-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9ae12311183so1367081366b.2
        for <linux-wpan@vger.kernel.org>; Sun, 01 Oct 2023 16:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696203451; x=1696808251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzzDJ/20k7un6ytFcQ3c+5NSkerSAlV3eQJ3FMdrkuI=;
        b=ibhLZuMZhnB1CzJRbPrCkwf4YaBclQtpCrIz1o5pxxCdfC9DkxiFh8ckClMyVuYXoS
         kVw5s1WccRI1rS+Ei9liBygNHa3bv5GMjNgQucT7dsGCVjP/d7NtJ9sAsUOzpKeGyFjJ
         5m9MMSGfrUMq+/Xf9826VWr6jxRaKmEMekm374oBwz+GS3HUwN3mJQhp0jNpyD602r5V
         Kn0eH2rZSE8UeK5FBOKbZO0NtJpneEtUtd6rgBgOoBNSuQWOCMw0EbRE0az5iRvrCREb
         3dPKkBebodQOPrSGVL9cwKHoFypuqDhJN348Y5/6o2HeaS4f0ZOR+TjzcXZVD9N9+dt9
         ZxQA==
X-Gm-Message-State: AOJu0Yw7EU/x1NUGiaOJq1cPYcTXiIWofjdf/5K8EhDI2BVSBV7n826B
        t4qkpsCLfHWoCqTB9YT1VkGY/M58IuIsiwe7eDB86EMrAaLOX1TgJTpJdfe1YNSGLeqwPhplkn2
        lKvqbFreUEzRhlV5Lqe7yL+QR1edpAlDjisNbKQ==
X-Received: by 2002:a17:907:75c6:b0:9a2:143e:a071 with SMTP id jl6-20020a17090775c600b009a2143ea071mr8853183ejc.17.1696203450879;
        Sun, 01 Oct 2023 16:37:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWAxK23hkFL/4pJMZN3u2siC1+4Ld+zYwCArK/4MJpc9vCrsnjka215ln4GBcQjIH92P9zRKjmlPYuz75N7IA=
X-Received: by 2002:a17:907:75c6:b0:9a2:143e:a071 with SMTP id
 jl6-20020a17090775c600b009a2143ea071mr8853176ejc.17.1696203450554; Sun, 01
 Oct 2023 16:37:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230924122231.716878-1-stefan@datenfreihafen.org>
 <20230925092202.0ab39c04@xps-13> <f390bb8d-c412-97c4-d574-4bde89bae5a2@datenfreihafen.org>
In-Reply-To: <f390bb8d-c412-97c4-d574-4bde89bae5a2@datenfreihafen.org>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sun, 1 Oct 2023 19:37:19 -0400
Message-ID: <CAK-6q+gOK9EEM_uyARj7AipPhbPYu=00rsAYD3tz+qbHcAXEuQ@mail.gmail.com>
Subject: Re: [PATCH 0/9] wpan-tools: switch to SPDX header for license and copyright
To:     Stefan Schmidt <stefan@datenfreihafen.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-wpan@vger.kernel.org, alex.aring@gmail.com,
        david.girault@qorvo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Tue, Sep 26, 2023 at 4:00=E2=80=AFAM Stefan Schmidt
<stefan@datenfreihafen.org> wrote:
>
> Hello Miquel, Alex.
>
> On 25.09.23 09:22, Miquel Raynal wrote:
> > Hi Stefan,
> >
> > stefan@datenfreihafen.org wrote on Sun, 24 Sep 2023 14:22:22 +0200:
> >
> >> Hello.
> >>
> >> I took some time to convert wpan-tools over to using the SPDX header f=
ormat to
> >> express copyright and license information. In this process we make the=
 actual
> >> license (ISC) more clear and allow downstream users of wpan-tools to h=
ave a
> >> machine readable format for license compliance.
> >>
> >> We are also using the reuse tool in our CI to check for this now and g=
enerate a
> >> SBOM file as an example.
> >
> > Nice addition!
> >
> > Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>
> Thanks Miquel.
>
> Alex, any remarks from your side or are you happy for me to land this in
> wpan-tools?
>

looks okay to me.

- Alex

