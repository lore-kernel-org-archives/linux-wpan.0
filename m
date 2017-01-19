Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:34021 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdASFVx (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 19 Jan 2017 00:21:53 -0500
Received: by mail-qt0-f177.google.com with SMTP id l7so49840571qtd.1
        for <linux-wpan@vger.kernel.org>; Wed, 18 Jan 2017 21:21:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b43bedcc-3e9e-c929-df7c-5b6e8672ad5e@pengutronix.de>
References: <CAAK7Ti8iY8O2W44948xaQA5t2WRxXT1uWTCCqW0N1Z10fqw+EQ@mail.gmail.com>
 <B56062D3-925C-4DA4-9EF4-1021F9EED9B5@gmail.com> <865f1a70-68e3-b947-f37d-ee856147c341@pengutronix.de>
 <86AE743A-D69C-469E-8693-95F7636BFD3F@gmail.com> <b43bedcc-3e9e-c929-df7c-5b6e8672ad5e@pengutronix.de>
From: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Date: Thu, 19 Jan 2017 10:43:31 +0530
Message-ID: <CAAK7Ti8AcR74D4c_b+K41eqvF5V-MpwUdokhvD0A1EGAB-ssCg@mail.gmail.com>
Subject: Re: please help me to integrate RPL in kernel
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Alexander Aring <aar@pengutronix.de>, joao.p.taveira@gmail.com
Cc: linux-wpan@vger.kernel.org

Thank You Alex and Jo=C3=A3o for your advice and guidance.


Right now i am following this site:
http://www.sixpinetrees.pl/2014/11/linux-rpl-router.html

if i have any doubts i will get in touch with you.


On Wed, Jan 18, 2017 at 4:59 PM, Alexander Aring <aar@pengutronix.de> wrote=
:
> Hi,
>
> On 01/18/2017 11:55 AM, Jo=C3=A3o Pedro Taveira wrote:
>> Hi Alex,
>>
>> Apologise me if I was too hard in my previous mail. It was a simply outf=
low about something that I kept for too long.
>>
>> You=E2=80=99re right about the wide range of changes and/or contribution=
s to kernel that RPL requires. I agree with you.
>>
>> What really wroth me was the =E2=80=9Cno way out=E2=80=9D situation.
>>
>> My implementation of linux-rpl touch mainly in netdev (ipv6, icmpv6, NUD=
, extended headers, routing tables=E2=80=A6). When I tried to contact netde=
v, I got no reply whatsoever. But before propose anything to netdev, I want=
ed to get linux-rpl to work with contiki using MRHOF and ETX. This would on=
ly work with feedback from 802.15.4.
>>
>
> Yes, but MRHOF and ETX is a later step. Maybe bring at first your RPL
> implementation mainline? You know... small steps?
>
> btw:
>
> I _never_ saw patches from you for a RPL implementation at netdev
> mailinglist. If nobody replies send a "ping" afterwards, etc.
>
>> So I tried to get some support from you. You were extremely active by th=
en getting wpan moving forward, so I thought you could help me get metrics =
from wpan stack. Since you were too busy and (now I think I didn=E2=80=99t =
explained correctly what I needed) you couldn=E2=80=99t help me.
>>
>> Now I know that you already faced and noticed the problem of MRHOF and E=
TX.
>>
>> In a previous mail with subject =E2=80=9Cthesis - MLE=E2=80=9D you wrote=
:
>> =E2=80=9CAnyway for 802.15.4 I need to implement some kernel parts to ca=
lculate
>> ETX, which means I need some ack received/non ack received counters or
>> something else which can be inserted for the ETX calculation (I need to
>> look into that).=E2=80=9D
>>
>> From wpan, this was and still is the only problem I need to solve regard=
ing to RPL and wpan subsystem. RPL works in a completely area of kernel.
>>
>> I hope get some time to get back to this project and get some kind of st=
ats/metrics system working with RPL Objective Function implementations.
>>
>
> I changed my decision right now to ETX from L2 ack. Because it will work
> on Unicast only. LQI is something which also works on multicast.
>
> Anyway If you see such problem then "send-patches", this is how open
> source works. Nobody will do anything when you talk about "I need that
> and that...".
>
> - Alex



--=20
Sincerely Your's

Janardhanachari Kella
Contact:+91-9908469599
E-mail: eni.chari@gmail.com
