Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:39200
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751935AbdCGTJO (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Tue, 7 Mar 2017 14:09:14 -0500
Subject: Re: iwpaninfo library for OpenWRT/LEDE
References: <CAJuUDwuHdbsfb5mFoUHTqQWRQPMtoVKjoLW_567D0WMpFk+yww@mail.gmail.com>
 <67c15ef5-02a3-ee03-1062-bd80467c6f2b@osg.samsung.com>
 <CAJuUDwu_Uxm=uE2kB+_frekH0FgVh23DerQHpCaO3fEej-dh_w@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <9c037a3f-2f51-c97e-fe3a-1da1a1d3ccdc@osg.samsung.com>
Date: Tue, 7 Mar 2017 20:09:00 +0100
MIME-Version: 1.0
In-Reply-To: <CAJuUDwu_Uxm=uE2kB+_frekH0FgVh23DerQHpCaO3fEej-dh_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Xue Liu <liuxuenetmail@gmail.com>
Cc: linux-wpan@vger.kernel.org

Hello.

On 03/06/2017 03:17 PM, Xue Liu wrote:
> Hi,
>
> 2017-03-01 17:56 GMT+01:00 Stefan Schmidt <stefan@osg.samsung.com>:
>> Hello.
>>
>> Sorry for the late reply. I had it tagged here but kind of forgot about it.
>
> No problem :)
>>
>> On 01/30/2017 01:45 PM, Xue Liu wrote:
>>>
>>> Hello,
>>>
>>> Recently I created a new project called iwpaninfo for OpenWRT/LEDE. It
>>> is a "clone" project from iwinfo and copied some code from wpan-tools.
>>
>>
>> From briefly looking over it this is basically a small library to access
>> nl_ieee802154 netlink information without dealing with netlink. Exposing
>> this interface as C and lua API. Correct so far? Anything I missed?
>>
>
> Yes. correct.
>
>> The primary goal is to use this inside OpenWRT/LEDE with the LuCI web
>> configuration interface?
>>
>
> Yes. It is my plan.
>
>>> Like iwinfo, it provides C and Lua APIs. So later I hope this package
>>> can be merged into OpenWRT/LEDE package repo.
>>
>>
>> The package only or also the git repo hosted by them? I could also offer you
>> putting it into the linux-wpan project on github if you plan to make this a
>> bit more generic (usable outside of OpenWRT/LEDE). Or you keep it on your
>> own space. Whatever you prefer. :)
>
> The package is now hosted by my Github. I think keep it there is OK.

That is fine, keep it there. And thanks for clarification that this is 
really tied to OpenWRT and needs uci and libubox.

I hope that helps the Ci40 people to have a nice integration of wpan on 
their OpenWRT setup. Maybe other hardware designs with a 15.4 
transceiver will follow. :)

regards
Stefan Schmidt

