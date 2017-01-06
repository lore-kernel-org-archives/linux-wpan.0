Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:47696
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932623AbdAFOLD (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 6 Jan 2017 09:11:03 -0500
Subject: Re: Requesting for process, to port driver from contiki to linux
References: <CAAK7Ti-pFkukD0wuRKKtg89oqeqAGycr--S1-ssdrXJwZsgT4Q@mail.gmail.com>
 <c24f9bf0-97bf-ab26-1a5a-d147ae72d3c4@osg.samsung.com>
 <CAAK7Ti_Pp9n4ERTmBrEeVwRtfi+SiKr9Lb6QgW_Wo+GHHku6gA@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <af5f2d15-ad3f-f25b-2967-69033d0b9ce1@osg.samsung.com>
Date: Fri, 6 Jan 2017 15:10:56 +0100
MIME-Version: 1.0
In-Reply-To: <CAAK7Ti_Pp9n4ERTmBrEeVwRtfi+SiKr9Lb6QgW_Wo+GHHku6gA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Cc: "linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>

Hello.

On 06/01/17 13:57, JANARDHANACHARI KELLA wrote:
> thankq Stefan.
>
> can you suggest me, any documents to develop/ write STM Spirit1
> supported module?

If you want to get any help or support here you should read what people 
are writing you. Alexander told you at least two times now to keep the 
mailing list in cc when replying and STOP top posting on this list. (If 
you do not know what he means I suggest you look it up). I you keep 
ignoring this people will just ignore you.

And if you no read again what I wrote you will see that I already 
suggested you to look at the existing drivers. We are a group of 
volunteers here working on Linux-wpan. If nobody has an interest to 
spent his time on writing a guide how to develop a driver for for 
transceiver XXX it just does not happen.

You best bet it to take a look at the existing drivers, learn how they 
are hooked up to the stack and interact with the kernel. Take the 
datasheet (if the vendor offers one to you) and match what logic you 
find there to drive the hardware to what we have.

regards
Stefan Schmidt
