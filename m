Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:41478
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750807AbdGMJBm (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 13 Jul 2017 05:01:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id AB066A0D4D
        for <linux-wpan@vger.kernel.org>; Thu, 13 Jul 2017 09:02:09 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6XAuysiZjF7t for <linux-wpan@vger.kernel.org>;
        Thu, 13 Jul 2017 09:02:08 +0000 (UTC)
Received: from [192.168.2.114] (pD9F79869.dip0.t-ipconnect.de [217.247.152.105])
        by osg.samsung.com (Postfix) with ESMTPSA id 5D665A05F0
        for <linux-wpan@vger.kernel.org>; Thu, 13 Jul 2017 09:02:08 +0000 (UTC)
Subject: Re: Applications on wpan-linux
References: <CAJuUDws4t0mSS4mONnXs=b9QLF28w9CTfQE-+2QKMnHg8_5HmA@mail.gmail.com>
 <b3e88cdb-59f7-5915-6abe-36c5b6cfc8ef@osg.samsung.com>
 <28959.1499804094@dooku.sandelman.ca> <20170712155110.itv5gqc4ohnh5lrz@omega>
 <13647.1499935823@dooku.sandelman.ca>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <d575f687-d5b1-9b3b-7caa-6fab81426850@osg.samsung.com>
Date: Thu, 13 Jul 2017 11:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <13647.1499935823@dooku.sandelman.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 07/13/2017 10:50 AM, Michael Richardson wrote:
> 
> Alexander Aring <alex.aring@gmail.com> wrote:
>      > About marketing: I think we need to make some tutorial for RIOT/Contiki
>      > to build e.g. a broder router. All others IoT MCU OS's make their own
>      > Border Router solution and feed their IPv6 Stack on $MCU_IOT_OS over
>      > SLIP and they do marketing with that.
> 
> That's not what I mean by marketing.
> Assume that we had some tutorial, where would people look for it?
> How would it get updated?
> 
> Documentation/networking/6lowpan.txt points at no web site.
> Documentation/networking//ieee802154.txt points at http://wpan.cakelab.org/
> and https://github.com/linux-wpan/wpan-tools
> 
> I don't know Christian Fromme, is he still around? He seems to own cakelab.org.
> I'm happy with github wiki documentation.

I wanted to try out github pages and maybe combine it with read the docs 
under our own domain. But I badly fall behind with my things on my todo 
list recently. Need to make some time for linux-wpan again.

I just looked again and linux-wpan.{net,org} are still free. I might 
just go ahead to register one of them which we can then use to point to 
whatever better marketing we come up with. :)

regards
Stefan Schmidt
