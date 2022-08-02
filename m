Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E68C00144
	for <linux-wpan@archiver.kernel.org>; Tue,  2 Aug 2022 00:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiHBAFq (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbiHBAFi (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 1 Aug 2022 20:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F90213F61
        for <linux-wpan@vger.kernel.org>; Mon,  1 Aug 2022 17:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659398731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0y1qZMQ8oTKnlfpbSF87m7miTl4iL3ySnx1IuZAnrSQ=;
        b=Aqg6Xo4P2gY7uLKMIY0uCKDmyUoSM36rlLX3OnFx81devvWPi7zgTKAPdkwHEVhIzXdVQc
        Mu768dEt+pe4l1H1OSFdvWAUX6a8EDufX5s1zYLPAuS2itaIi6L5FE8ys5pBEEw/6HI/SU
        lzR0Gahrnf2f5O3Ua/sK5Z+gALk+x50=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114--UhtAwiBNJimmi0goQ5eUA-1; Mon, 01 Aug 2022 20:05:29 -0400
X-MC-Unique: -UhtAwiBNJimmi0goQ5eUA-1
Received: by mail-qt1-f200.google.com with SMTP id cc11-20020a05622a410b00b0033a100489c4so101042qtb.20
        for <linux-wpan@vger.kernel.org>; Mon, 01 Aug 2022 17:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=0y1qZMQ8oTKnlfpbSF87m7miTl4iL3ySnx1IuZAnrSQ=;
        b=7U2VMR41c4JCYbbpwtC/7TeAxreWPowYG9FY/WlYUbSOGPSfTFCbIceKeZ+5FmHQgL
         YRFVLElRoLKK0Bf/jYeu/lOfE+TZrp3n6QdDk1ZZ7dopkAjL/PZM/pf/fsOvOV7pwFB/
         nlN6fTrLuccZh2I6ttMhMqiNuu/NSQ3thxLWLQ6UxzQttUCW6m1wuWZvO3BaY5Cbq0ye
         vbWEN2vR/vX+wpVj55HuS4DmFlfSGU+cvAwDFh0sW9hma5+2Y4k6FOIyvcvtGEZPqrkw
         bzgGjh/EMVtreWqBWOtQj633hN/AE3SHT6h9/1YF+3TiaHjrR33mCgV6y0QGrFmnIKrI
         CTsw==
X-Gm-Message-State: AJIora+XabiTkeBw6IFqQLNAvAI6b2BgoDaAN86OozJl7euG4tiO4UlS
        XnXZk2w5JdySXJast9MxZ8Gt+Ww/CKRbuszxcSzv3KzfCNnTOU3B+kD8zFLu77mAzBstMWxJHW1
        rBD2X1gHodMvupFcU1nV0y3OsDn+KHrxBko265Q==
X-Received: by 2002:ac8:6bc3:0:b0:31e:dc36:6cf8 with SMTP id b3-20020ac86bc3000000b0031edc366cf8mr16602141qtt.470.1659398728311;
        Mon, 01 Aug 2022 17:05:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tCWG/aCMfEMxl8ZQr14JA6F7B2PWS09WUL5N06MfPtUb2a9YnwjAVMTRa75GIQv6KEfsF0Vl8td0hBCxGpJuU=
X-Received: by 2002:ac8:6bc3:0:b0:31e:dc36:6cf8 with SMTP id
 b3-20020ac86bc3000000b0031edc366cf8mr16602124qtt.470.1659398728132; Mon, 01
 Aug 2022 17:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com> <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
In-Reply-To: <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 1 Aug 2022 20:05:17 -0400
Message-ID: <CAK-6q+g3iUZ0wf_U7V7wH9Dgbibdu32xCKGrFz86zLnDKxtHMA@mail.gmail.com>
Subject: Re: [PATCH wpan-tools 0/7] iwpan: Support scanning/beaconing
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>,
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

On Sun, Jul 3, 2022 at 9:18 PM Alexander Aring <aahringo@redhat.com> wrote:
>
> Hi,
>
> On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >
> > Hello,
> >
> > This series follows the work done in the Linux kernel stack: now that
> > the core knows about the different netlink commands and attributes in
> > order to support scanning and beaconing requests from end-to-end, here
> > are the userspace changes to be able to use it.
> >
> > Here is a list of the new available features.
> >
> > * Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
> >   valid for passively sending beacons at regular intervals. An interval
> >   of 15 would request the core to answer BEACON_REQ.
> >   # iwpan dev coord0 beacons send interval 2 # send BEACON at a fixed rate
> >   # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ only
> >   # iwpan dev coord0 beacons stop # apply to both cases
> >
> > * Scanning all the channels or only a subset:
> >   # iwpan dev wpan1 scan type passive duration 3 # will not trigger BEACON_REQ
> >   # iwpan dev wpan1 scan type active duration 3 # will trigger BEACON_REQ
> >
> > * During scans, there is a dedicated netlink channel event to listen to
> >   in order to get events like "a new coordinator was discovered" or "the
> >   scan is over". When beacons from new devices are received, the tool
> >   would print something like:
> >   PAN 0xabcd (on coord1)
> >         coordinator 0xe673d7a3f3a87ccc
> >         page 0
> >         channel 13
> >         preamble code 0
> >         mean prf 0
> >         superframe spec. 0x4f11
> >         LQI 0
> >
> > * It is also possible to monitor the events with:
> >   # iwpan event
> >
> > * As well as triggering a non blocking scan:
> >   # iwpan dev wpan1 scan trigger type passive duration 3
> >   # iwpan dev wpan1 scan done
> >   # iwpan dev wpan1 scan abort
>
> why do we need an abort?

I'm still thinking about it. Is done a kind of "block until scan is
done", but isn't this an event to signal when the mac operation is
done? What is the difference between done and abort, is this not just
"end" as I don't want to be in scan mode anymore (because we block all
interface traffic during this time)?

- Alex

