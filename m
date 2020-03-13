Return-Path: <SRS0=xUNG=46=vger.kernel.org=linux-wpan-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A464DC10DCE
	for <linux-wpan@archiver.kernel.org>; Fri, 13 Mar 2020 13:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7956F20746
	for <linux-wpan@archiver.kernel.org>; Fri, 13 Mar 2020 13:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JND9lZaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgCMNyc (ORCPT <rfc822;linux-wpan@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:54:32 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:42828 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgCMNyb (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 13 Mar 2020 09:54:31 -0400
Received: by mail-qt1-f175.google.com with SMTP id g16so7486946qtp.9
        for <linux-wpan@vger.kernel.org>; Fri, 13 Mar 2020 06:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xrkyVLuX+8rLlauNwddfKJ7qgD/xEJlFT0VeeKiA4u4=;
        b=JND9lZaEgLA/Yg+PjTNjWNml3rPqMrkk/4ATebfoM3pM24Ewe19QhhOgHGxx2YO0Ho
         DCknsngNdmqZ7eKOwM1Tr1aSlqkDqF9FWwjbSKGEOd4jFUVMs2nt+c9DNxb3ywCsUW7h
         hUW1OnsyVq3uEb2ZCwbXQjV/Qc6FX3pGn8kjFW+5FSM4JUcuftSrHUOMu2TZImWyPero
         4NeIkAj6b5/BtdTtGP0iffOoRS3k38ctbT2TU/x3XoDjCWK8a9EyEpn6xW7wuzM0ZNHu
         7B0pWKZjKE6a2ntgFEFBnSPkXbGhWaYgxcC/whidufq3+R7x3io5p+sNzlajyEu6j90m
         4acQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xrkyVLuX+8rLlauNwddfKJ7qgD/xEJlFT0VeeKiA4u4=;
        b=hCMSB6668u9p6SUTUnh1jSImHOfIng2Vf0h9Pz6ZY/UCa/PNrUm8Dbh4aFYVGHeA9G
         jdrTHw8giSKskKaQj2GZRU/QuYjRvh1jNbPxNEJ/7qnRwnCDiOmgvuWkpEpgP0BY7lOv
         Btrlwdm95NtvHv2OOfthcRhkYlkn2dcJCHvZ+26wu+Iwm566pNUupMNl5Tagtkrfoph7
         4dGIjkaqmAK+wWWWIU4Cjp/fDc8Cs31w+6VPE7BKJbSnnB5bqUImr/ub1ju70wuj6JxR
         b5XEoE0jInveeESu8QtogsFmojs7ctrcufIGJGGjR4pqRLXMoIlLzAtN/YdEWlNDDGYB
         MfMQ==
X-Gm-Message-State: ANhLgQ2JV9nzCLA19b609GbA+0X/C5hNneAFMlW849mgkxp5syC6Qa2f
        sE3xOu265T01FG7iMw/TKqJinwNB
X-Google-Smtp-Source: ADFU+vvU3BtnNT9XsSeB6eJEb1mL+OJKvcy915ZdMJLKWNrVR3OMOjDWXnqJWsHxATCTxQIcnUwP+A==
X-Received: by 2002:aed:2625:: with SMTP id z34mr6713442qtc.276.1584107670847;
        Fri, 13 Mar 2020 06:54:30 -0700 (PDT)
Received: from ryzen ([216.154.3.104])
        by smtp.gmail.com with ESMTPSA id w134sm29458059qka.127.2020.03.13.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:54:30 -0700 (PDT)
Date:   Fri, 13 Mar 2020 09:54:23 -0400
From:   Alexander Aring <alex.aring@gmail.com>
To:     Victhor Foster <victhor.foster@ufpe.br>
Cc:     linux-wpan <linux-wpan@vger.kernel.org>
Subject: Re: Interfacing mac802154 stack with userspace applications
Message-ID: <20200313135423.zwimsw5u2o7dnanc@ryzen>
References: <547191739.3620092.1572042009933.JavaMail.zimbra@ufpe.br>
 <CAB_54W5B+bjAHQU-JYbg34=F5c0HMV9q30uPPtopHqNhNChO8A@mail.gmail.com>
 <2006988758.2143768.1573549407203.JavaMail.zimbra@ufpe.br>
 <763926392.1016039.1583799908366.JavaMail.zimbra@ufpe.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <763926392.1016039.1583799908366.JavaMail.zimbra@ufpe.br>
User-Agent: NeoMutt/20180716
Sender: linux-wpan-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wpan.vger.kernel.org>
X-Mailing-List: linux-wpan@vger.kernel.org

Hi,

On Mon, Mar 09, 2020 at 09:25:08PM -0300, Victhor Foster wrote:
> I have resumed work on this project, and I decided to implement a few
> changes. I abandoned the socat approach and came up with a different
> implementation, modifying the linux-wpan example programs.
> 

aha, which one?

> I made two programs, one that receives packets from a wpan interface
> and outputs them to a UDP port, while the other program receives
> packets from a UDP port and sends them to a wpan interface. It seems
> to work well enough, but there's a problem with my approach.
> 

You telling me something about UDP to a wpan interface. This makes no
sense except you also building some IP layer in user space.

> I need to get outgoing packets from the wpan interface. Is there a way
> to filter packets coming through a raw socket, such that only outgoing
> packets come out of the socket?
> 

Now you saying something about RAW sockets, what kind of raw sockets?

> Right now, I'm not filtering for outgoing packets, so when packets are
> received through my program and sent to the wpan interface, the same
> packets come out of the interface, as there's no filtering being done,
> causing a loop.
> 
> I tried using the sll_pkttype field in the raw socket structure, but
> all packets received by the socket have the same value, so it's not
> useful, unfortunately.
> 

No, it smells for me you want to do something with traffic control and
egress path.

- Alex
