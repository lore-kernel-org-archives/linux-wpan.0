Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-it0-f46.google.com ([209.85.214.46]:39317 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeIJUBa (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 10 Sep 2018 16:01:30 -0400
Received: by mail-it0-f46.google.com with SMTP id h1-v6so29087658itj.4
        for <linux-wpan@vger.kernel.org>; Mon, 10 Sep 2018 08:06:58 -0700 (PDT)
Date: Mon, 10 Sep 2018 11:06:47 -0400
From: Alexander Aring <aring@mojatatu.com>
Subject: Re: about openthread and 6lowpan
Message-ID: <20180910150647.dcwoyslxrusvcj7j@x220t>
References: <SG2PR04MB31586E124C6C9A919150F826EF000@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB3158366EFF8CBC241C84FFD5EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <SG2PR04MB315811F19F2A13136294C6A9EF060@SG2PR04MB3158.apcprd04.prod.outlook.com>
 <3503.1536526189@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3503.1536526189@localhost>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Sujay G <sujay.g@hcl.com>, "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hi,

On Sun, Sep 09, 2018 at 04:49:49PM -0400, Michael Richardson wrote:
> 
> Sujay G <sujay.g@hcl.com> wrote:
>     > I have been testing openThread on Docker. I wanted to use 6Lowpan with
>     > openthread.  I assumed openThread would interact with wpan interfaces
>     > and added wpan interfaces in container namespace but it did not work.
> 
>     > Then I came across change for 6Lowpan.  Comparison yielded changes in 7
>     > files vs the latest openThread repositiry
>     > github.com/openthread/openthread/compare/master...linux-wpan:af802154
> 
> Why are you asking the linux-wpan ML about openthread patches? :-)
> 

it's okay.

> Alex did some patches to make openthread work better with the virtual
> interfaces... it's up to the openthread people to adopt them or not.
> 

What is does is to run openthread as somewhat "user space stack" with
limited functionality on monitor interfaces. It's good for debugging.

"limited functionality" is e.g. not ack handling, every frame get to
userspace... it's a pain to run productive I think.

I worried, here was somebody who said "it just works for him on node
interfaces", but in this case the kernel run filtering... I am worried
that people using it in this way and don't know what they do.

>     > I manually merged the files and am trying to resolve the errors.
> 
>     > Had few queries regarding the openThread and 6Lowpan
> 
>     > Why was the project (af802154) abandoned ?  Was openThread working with
>     > the above 6Lowpan changes ?  Does the current openThread stack support
>     > 6Lowpan ? any configuration needs to be enabled ?  or is it the right
>     > way to port the af802154 to current implementation of openthread ?
> 
> You could rebase it, and maybe you have more influence with the
> openthread people than we do.

agree.

- Alex
