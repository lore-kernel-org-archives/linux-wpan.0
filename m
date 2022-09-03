Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D093ECAAD4
	for <linux-wpan@archiver.kernel.org>; Sat,  3 Sep 2022 18:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiICS3U (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Sat, 3 Sep 2022 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbiICS3T (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 3 Sep 2022 14:29:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E802D491CB
        for <linux-wpan@vger.kernel.org>; Sat,  3 Sep 2022 11:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662229758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2JFtouHZvYoDswOl7hDRXvN6uVGBX2uC31/Be7OBlHY=;
        b=OqYIYLp73hrNI83++b+/4Y+Te0UdQ6wUO0ZA3k2SdB+qPPBwodOzlsNkpt2cy7NI51elCf
        ez+kFq2nxLYqnUqQRs2qwQIBX8W7wLBJEmpB0iwdbqga/e2o7gfE33E/KRDa0SVAdwl5fQ
        9DO1AMZ3nyKo7+8oqitgEl+4mj9+svg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-RA4Vu650NaiT1XNhQNzLXQ-1; Sat, 03 Sep 2022 14:29:16 -0400
X-MC-Unique: RA4Vu650NaiT1XNhQNzLXQ-1
Received: by mail-qt1-f198.google.com with SMTP id b10-20020a05622a020a00b003437e336ca7so3934134qtx.16
        for <linux-wpan@vger.kernel.org>; Sat, 03 Sep 2022 11:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2JFtouHZvYoDswOl7hDRXvN6uVGBX2uC31/Be7OBlHY=;
        b=3v06UpUiBpP7plT/sUWogqxPEC/8W/+MXATpyCdrHqLbd96Secy5FWEOtXx/9pB0KG
         Q8TnlFP21lzMZ9YsP3pt3wCR9aKIyPLlItHOrlaNI7ZA6d+J95gOqP1uJndd5DcHsA89
         ytbCD5sFlP1Su933iAZOIupPgzfdtzWOlvj0G9CCZGGDzKQMNafNVj9J2+j8k4hUUrll
         aQx1A6BHM90wBcZjBfQ4FsMWpWCgKSOxpjG/QCpu4fSzCRu5iaXFCdwvBLa3T1N/O1Uu
         Qie4lQbbde+F5FAF2nwYGyWNo1GdCmCzNyP8WJ80p/vl78X7UX4Rm7UriexpQPihk218
         LDPw==
X-Gm-Message-State: ACgBeo1hidThYOfLB/5yu2T1QVb6cyGVVQ6vX56fgeiG/sqg3ZBrhdEq
        uFRatmstS2E/0bIoSc1zlBjQCg3fIgqSJRe9jyq0dgRGiqiZ+Ca5zD6ltupCtJg0huhthjbr0Xn
        brnTMW3Hw/dQez5S7yujU5YFuuUL1p0y7bkUK2w==
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id x4-20020a05622a000400b0034494b7a396mr32570600qtw.123.1662229756321;
        Sat, 03 Sep 2022 11:29:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4tA06EEjnq8KwvTgtBIApULLViUAdlXrHA+PUz9Afw1X1Z5XBSSBU7taWFW+mKX5XPqznbgvFI3jkZMvtkCq8=
X-Received: by 2002:a05:622a:4:b0:344:94b7:a396 with SMTP id
 x4-20020a05622a000400b0034494b7a396mr32570578qtw.123.1662229756131; Sat, 03
 Sep 2022 11:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143052.1267509-1-miquel.raynal@bootlin.com>
 <20220823182950.1c722e13@xps-13> <CAK-6q+jfva++dGkyX_h2zQGXnoJpiOu5+eofCto=KZ+u6KJbJA@mail.gmail.com>
 <20220824122058.1c46e09a@xps-13> <CAK-6q+gjgQ1BF-QrT01JWh+2b3oL3RU+SoxUf5t7h3Hc6R8pcg@mail.gmail.com>
 <20220824152648.4bfb9a89@xps-13> <CAK-6q+itA0C4zPAq5XGKXgCHW5znSFeB-YDMp3uB9W-kLV6WaA@mail.gmail.com>
 <20220825145831.1105cb54@xps-13> <CAK-6q+j3LMoSe_7u0WqhowdPV9KM-6g0z-+OmSumJXCZfo0CAw@mail.gmail.com>
 <20220826095408.706438c2@xps-13> <CAK-6q+gxD0TkXzUVTOiR4-DXwJrFUHKgvccOqF5QMGRjfZQwvw@mail.gmail.com>
 <20220829100214.3c6dad63@xps-13> <CAK-6q+gJwm0bhHgMVBF_pmjD9zSrxxHvNGdTrTm0fG-hAmSaUQ@mail.gmail.com>
 <20220831173903.1a980653@xps-13> <20220901020918.2a15a8f9@xps-13>
 <20220901150917.5246c2d0@xps-13> <CAK-6q+g1Gnew=zWsnW=HAcLTqFYHF+P94Q+Ywh7Rir8J8cgCgw@mail.gmail.com>
 <20220903020829.67db0af8@xps-13> <CAK-6q+hO1i=xvXx3wHo658ph93FwuVs_ssjG0=jnphEe8a+gxw@mail.gmail.com>
 <20220903180556.6430194b@xps-13> <CAK-6q+guC=eYQtUX=2wvhUTyNC+iNWSVuiBHC94soVUrLoBYGg@mail.gmail.com>
In-Reply-To: <CAK-6q+guC=eYQtUX=2wvhUTyNC+iNWSVuiBHC94soVUrLoBYGg@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Sat, 3 Sep 2022 14:29:05 -0400
Message-ID: <CAK-6q+hyKFS0kPRkG=AKV7z5E1OdGEbjPSKZ0uFEgcK_8WC=Ow@mail.gmail.com>
Subject: Re: [PATCH wpan-next 01/20] net: mac802154: Allow the creation of
 coordinator interfaces
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        David Girault <david.girault@qorvo.com>,
        Romuald Despres <romuald.despres@qorvo.com>,
        Frederic Blain <frederic.blain@qorvo.com>,
        Nicolas Schodet <nico@ni.fr.eu.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Sat, Sep 3, 2022 at 2:21 PM Alexander Aring <aahringo@redhat.com> wrote:
...
>
> Assume you always get an ack back until somebody implements this
> feature in their driver (It's already implemented so as they return
> TX_SUCCESS). We cannot do much more I think... it is not robust but
> then somebody needs to update the driver/firmware.
>
> It's more weird if the otherside does not support AACK, because ARET
> will send them 3 times (by default) the same frame. That's why we have
> the policy to not set the ackreq bit if it's not required.
>
> > What is your "less worse" choice?
> >
> > > Btw: I can imagine that hwsim "fakes" such
> > > offload behaviours.
> >
> > My current implementation actually did handle all the acks (waiting for
> > them and sending them) from the MAC. I'm currently migrating the ack
> > sending part to the hw. For the reception, that's the big question.
> >
>
> In my opinion we should never deal with ack frames on mac802154 level,
> neither on hwsim, this is an offloaded functionality. What I have in

* except of course in cases of monitors, but monitors really aren't
part of the network and they are sniffers... A monitor can indeed send
frames out, which could cause a lot of trouble in the network if you
want to. It's a playground thing to do experiments... Here we never
analyze any payload received and forward it directly to the user, it's
also a kind of kernel bypass. I know people run some user space stacks
with it (including myself) but they get problems until it gets into
e.g. ackknowledge handling.

- Alex

