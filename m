Return-Path: <linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55D0ECAAA2
	for <linux-wpan@archiver.kernel.org>; Fri, 26 Aug 2022 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiHZBXE (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Thu, 25 Aug 2022 21:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHZBXD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 25 Aug 2022 21:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C43C9938
        for <linux-wpan@vger.kernel.org>; Thu, 25 Aug 2022 18:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661476981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ViIqayQYinXW6Uc5m9xaEFbXEU8rAnolGpQ7GZrlZIA=;
        b=YGEhOJbk2YM3NbrhwUgANEM1Ix+FJ0MYVSoNN2Nzzhre6rc3XKqtehA1HSLoD6c4fBvtpE
        B8WUxmSaVKx5amHFD/Ppn0sLLwpB0Y0q0qZYgvyRJbGKFx9xm5MuuyJ6JAxmFktNzPHymK
        ZmCODUCAdeWWEaPA2gWAb4NXnsvTr2s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-602-i9IaR_MeP9m5R8P37v8GVw-1; Thu, 25 Aug 2022 21:23:00 -0400
X-MC-Unique: i9IaR_MeP9m5R8P37v8GVw-1
Received: by mail-qv1-f70.google.com with SMTP id o6-20020ad443c6000000b00495d04028a6so9168qvs.18
        for <linux-wpan@vger.kernel.org>; Thu, 25 Aug 2022 18:23:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ViIqayQYinXW6Uc5m9xaEFbXEU8rAnolGpQ7GZrlZIA=;
        b=N1aCbLIc4gWCbM7OtSoHThbqVuJnwgwSzTEd517NX2VPYx5+mLrmEUHQlP1ClsnOF8
         bNhhEuPrwaiKNRoUX6sSRs9mGsZJ5VUGdtppOd2cKVKloLfbWNXEuPM2M0xbWL3F7cz4
         C97XcXqz06uyWD+MeAVBjGTtYJgQyGggOlk6nJjdJJD6sAhl1XWL/7P5eJ8jkMF8PRPA
         CstXcsHYgSw+dr5q2HjAxdHcQmX8LYFNm2KxNaO9oz1dMxMtenZf5IF0sjTy/pjvfny/
         L1oG0+C1PEoVSMJ6mHb4scfp6jqZb+SD86UUf/hSpmZ3iFLM00KynCVNZfKX50uQoOYf
         EYpw==
X-Gm-Message-State: ACgBeo3ZYmL6xYoJE5kyijgRYVXqleEKKl6FAKau6AzQYojWd6KYyYns
        VIDXy+vSSH9SRH/4Ok94Z8d5NFs59HzmnbPtCDFDcgcO/BPpkLGQG+dr9HYjMDLv2bVLjWmQqYK
        eZwI1mKMdbVgt37A456Xrl4dRvORxDrbgkpLa0Q==
X-Received: by 2002:a37:b741:0:b0:6b9:3b67:d0a7 with SMTP id h62-20020a37b741000000b006b93b67d0a7mr4947300qkf.770.1661476980028;
        Thu, 25 Aug 2022 18:23:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6YtotaUg4SO0WwESg1NcJGJ262aiGUaRWVy3rqRq+EEDFapwpn30aj+irmF5lVWBNrGN561f+Ior8fjYcsMmw=
X-Received: by 2002:a37:b741:0:b0:6b9:3b67:d0a7 with SMTP id
 h62-20020a37b741000000b006b93b67d0a7mr4947293qkf.770.1661476979793; Thu, 25
 Aug 2022 18:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220701143434.1267864-1-miquel.raynal@bootlin.com>
 <CAK-6q+hUc0Cm+_9OyLNqX=gKNOO-3TU4ERu_bZKm=Qf-c9F-ug@mail.gmail.com>
 <20220819190654.6af62bca@xps-13> <CAK-6q+gk2rt3crszskUOxxeTYb3OY+ybLsga6f6VC5RQmjY44w@mail.gmail.com>
 <20220825145516.14bd5b45@xps-13>
In-Reply-To: <20220825145516.14bd5b45@xps-13>
From:   Alexander Aring <aahringo@redhat.com>
Date:   Thu, 25 Aug 2022 21:22:48 -0400
Message-ID: <CAK-6q+jy75nUH1dzr5KCFnLJ=QALLv5keXboTtbjQ7uh-KWwGg@mail.gmail.com>
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

On Thu, Aug 25, 2022 at 8:55 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Alexander,
>
> aahringo@redhat.com wrote on Tue, 23 Aug 2022 21:36:23 -0400:
>
> > Hi,
> >
> > On Fri, Aug 19, 2022 at 1:07 PM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > >
> > > Hi Alexander,
> > >
> > > aahringo@redhat.com wrote on Sun, 3 Jul 2022 21:18:40 -0400:
> > >
> > > > Hi,
> > > >
> > > > On Fri, Jul 1, 2022 at 10:39 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > This series follows the work done in the Linux kernel stack: now that
> > > > > the core knows about the different netlink commands and attributes in
> > > > > order to support scanning and beaconing requests from end-to-end, here
> > > > > are the userspace changes to be able to use it.
> > > > >
> > > > > Here is a list of the new available features.
> > > > >
> > > > > * Sending (or stopping) beacons. Intervals ranging from 0 to 14 are
> > > > >   valid for passively sending beacons at regular intervals. An interval
> > > > >   of 15 would request the core to answer BEACON_REQ.
> > > > >   # iwpan dev coord0 beacons send interval 2 # send BEACON at a fixed rate
> > > > >   # iwpan dev coord0 beacons send interval 15 # answer BEACON_REQ only
> > > > >   # iwpan dev coord0 beacons stop # apply to both cases
> > > > >
> > > > > * Scanning all the channels or only a subset:
> > > > >   # iwpan dev wpan1 scan type passive duration 3 # will not trigger BEACON_REQ
> > > > >   # iwpan dev wpan1 scan type active duration 3 # will trigger BEACON_REQ
> > > > >
> > > > > * During scans, there is a dedicated netlink channel event to listen to
> > > > >   in order to get events like "a new coordinator was discovered" or "the
> > > > >   scan is over". When beacons from new devices are received, the tool
> > > > >   would print something like:
> > > > >   PAN 0xabcd (on coord1)
> > > > >         coordinator 0xe673d7a3f3a87ccc
> > > > >         page 0
> > > > >         channel 13
> > > > >         preamble code 0
> > > > >         mean prf 0
> > > > >         superframe spec. 0x4f11
> > > > >         LQI 0
> > > > >
> > > > > * It is also possible to monitor the events with:
> > > > >   # iwpan event
> > > > >
> > > > > * As well as triggering a non blocking scan:
> > > > >   # iwpan dev wpan1 scan trigger type passive duration 3
> > > > >   # iwpan dev wpan1 scan done
> > > > >   # iwpan dev wpan1 scan abort
> > > >
> > > > why do we need an abort?
> > >
> > > Perhaps the tool --help would have helped to get the naming, but we
> > > need:
> > > - a command to start a scan, either use:
> > >   * "scan" alone and it is synchronous, I mean the command returns when
> > >     the scan is over
> > >   or
> > >   * "scan trigger" which is asynchronous, and returns immediately after
> > >     starting the operation
> > > - if the scan was started asynchronously with the "trigger" keyword,
> > >   the "done" command will wait until the scan is over (maybe this one
> > >   needs to be renamed?)
> > > - if the user made a mistake and do not want to remain blocked for
> > >   several minutes (a scan can last for very long time), we need the
> > >   "abort" command to tell the kernel to stop and return to a standard
> > >   state. Once this has been processed and the scan effectively stopped,
> > >   the kernel will send a nl command saying the scan is over (which
> > >   "scan done" would capture)
> > >
> >
> > For me, trigger and done should be for the simple cli use case in one
> > command like "scan list". It will block them and trigger any scan
> > event popping up. The user can send SIGINT to stop scanning?
> >
> > Although there should be still available an asynchronous way which is
> > for me "scan trigger" (non-blocking) and the user can do "iwpan
> > monitor" to observe upcoming events (all inclusive scan) and tell
> > optionally "scan done" to stop scanning if necessary (which probably
> > also produces an event to notify all listeners e.g. iwpan monitor).
> >
> > However I think most people using iwpan want to trigger and wait and
> > the cli is filling up events and blocks until it's done (that would be
> > a combination with trigger/monitor into one command).
> >
> > Both solutions should be possible over cli?
>
> Yes, that's what I was saying, the two solutions are already supported.
> The iwpan tool is being enhanced with the "scan" composite command,
> - either "scan" is given an additional keyword and makes just that
>   (trigger, abort, done) and returns as soon as this precise
>   command is done (eg. it returns almost immediately on "trigger")

But why do we need to have a done command?

Sorry, I still don't get that.

> - or, no additional command is provided (only the parameters for the
>   scan) and the command does an equivalent to "trigger + monitor +
>   done" which blocks after launching the scan, shows the results when
>   they arrive, and returns once the scan is finished.

"trigger + monitor" there is no done command needed here or? The
process should unblock when it's done, and for SIGINT/SIGKILL send an
abort? Maybe a done event when the scan is "successful" finished and
everything that was there in the channel/page combinations was scanned
without an abort.

We need to consider that other processes listen to events? They should
be aware of what's happening there? There should be some event
sequence going on "trigger event" + "loop of found something event" +
"either abort or done"?

>
> Do you want something more? I just miss a "monitor" command I guess, I
> may add it.
>

Yea, monitor sounds like ip monitor, udevadm monitor, etc. to listen
to all those 802.15.4 subsystem events. I would take a look into it
for any scan results. At the end you should be able to do a blocked
scan and monitor at the same time and they should at least provide
similar events.
Probably the blocked scan with nicer output and filtered and the
monitor is for everything that is going on in 802.15.4 there.

- Alex

