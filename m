Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f170.google.com ([209.85.216.170]:45189 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeIJUNV (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Sep 2018 16:13:21 -0400
Received: by mail-qt0-f170.google.com with SMTP id g44-v6so24525356qtb.12
        for <linux-wpan@vger.kernel.org>; Mon, 10 Sep 2018 08:18:46 -0700 (PDT)
Date: Mon, 10 Sep 2018 11:18:43 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: about openthread and 6lowpan
Message-ID: <20180910151843.dqdlhnttlh7gdsmi@x220t>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Sujay G <sujay.g@hcl.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On Sun, Sep 09, 2018 at 03:05:50PM +0000, Sujay G wrote:
>  Hi,
> 
> I have been testing openThread on Docker. I wanted to use 6Lowpan with openthread.
> I assumed openThread would interact with wpan interfaces  and added  wpan interfaces in container namespace  but it did not work.
> 
> Then I came across change for 6Lowpan.  Comparison yielded changes in 7 files  vs the latest openThread repositiry
> github.com/openthread/openthread/compare/master...linux-wpan:af802154
> 
> I manually merged the files and am trying to resolve the errors.
> 
> Had few queries regarding the openThread and 6Lowpan
> 
> Why was the project (af802154) abandoned ?

I am personally not interested to run openthread as a user space
solution which can be sold as "not use Linux, use mine software".

> Was openThread working with the above 6Lowpan changes ?

With limitations, which can be improved to support more user space
stacks in the wpan subsystem. I used only do testing against their "MLE"
implementation.

> Does the current openThread stack support 6Lowpan ? any configuration needs to be enabled ?    or is it the right way to port the  af802154 to current implementation of openthread ?
> 

"openThread stack support 6Lowpan"

I asking me this question myself. According their MLE implementation
it's a forked standard from IETF draft. So you can't be sure if they ever
changed something in IETF 6LoWPAN, foo which is then a forked standard.

Also according to "MLE", they sold it with the words "MLE" but it wasn't "MLE",
so you can't be sure in any 6LoWPAN protocols as well.

I think openthread are still "good people" because they have an open
implementation. It's totally weird that the standard is closed but there
exist open implementation which seems to be Thread certificated.

Thread works in this case only as user space stack with openthread and a
RAW L2 frame socket layer as AF_PACKET offers you and not in any
productive case because limitations.

---

The right way? It's not, see my other post about my complain why I don't
want to work on openthread as user space stack. [0]

We need to make some library wrapper around openthread and map it to Linux
6LoWPAN/802.15.4 stack.

- Alex

[0] https://www.spinics.net/lists/linux-wpan/msg04949.html
