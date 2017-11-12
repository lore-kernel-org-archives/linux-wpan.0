Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-vk0-f46.google.com ([209.85.213.46]:54986 "EHLO
        mail-vk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752275AbdKLAJF (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Sat, 11 Nov 2017 19:09:05 -0500
Received: by mail-vk0-f46.google.com with SMTP id b18so5830702vkd.11
        for <linux-wpan@vger.kernel.org>; Sat, 11 Nov 2017 16:09:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOHTAphUMTNho7hA3kP8sZNr7zODOUGB8uWwpYaJ2fx8SP536w@mail.gmail.com>
References: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no> <730.1510335972@obiwan.sandelman.ca>
 <D59C859A-19A4-4898-A7E1-19C09BEBEA4E@ntnu.no> <22033.1510426407@obiwan.sandelman.ca>
 <7828B4AD-AE60-4783-829D-899F028CB3A6@ntnu.no> <CAOHTAphUMTNho7hA3kP8sZNr7zODOUGB8uWwpYaJ2fx8SP536w@mail.gmail.com>
From: Alexander Aring <aring@mojatatu.com>
Date: Sat, 11 Nov 2017 19:09:04 -0500
Message-ID: <CAOHTApgGOB4C9LDqej+beSNU3TXr6c-uR=RLOKzFduG=5aedkQ@mail.gmail.com>
Subject: Re: Bridging a lowpan interface
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: David Palma <david.palma@ntnu.no>
Cc: Michael Richardson <mcr@sandelman.ca>, linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

On Sat, Nov 11, 2017 at 7:06 PM, Alexander Aring <aring@mojatatu.com> wrote:
> Hi,
>
> On Sat, Nov 11, 2017 at 5:59 PM, David Palma <david.palma@ntnu.no> wrote:
>>
>>> On 11 Nov 2017, at 19:53, Michael Richardson <mcr@sandelman.ca> wrote:
>>>
>>>
>>> David Palma <david.palma@ntnu.no> wrote:
>>>> I'm all for routing and starting with RPL is fine. However, the idea
>>>> was also to enable traffic differentiation based on flows (the SDN
>>>> part), without breaking them, and not only based on IP
>>>> addresses. That's why I mentioned that I used routing and ip6tables.
>>>
>>> I don't understand what the problem is.
>>> What would you do with bridged interfaces in an SDN?
>>
>> For example, if you use Open vSwitch for the SDN part, you add an interface to a bridge and manage flows from there.
>>
>>> What kind of breaking are you speaking of?
>>
>> By breaking I mean, for example:
>> - establish a CoAP transaction with DTLS through one interface/network (e.g. .11, fd03::120)
>
> Check out ndisc proxy for IPv6.
>
> There is no automatically handling for that inside the kernel (please
> send-patches, somebody wanted already such feature). What I mean for
> IPv4 yes, but for IPv6 you need a daemon like [0].
>

btw: we need short address handling for this... because 2 types of mac
addresses is not really supported by net core api and currently we
handle this _very_ 802.15.4 interface specific. Just you know about...
that you run into issues with that (When you not solve it). Patches
are welcome always!

- Alex
