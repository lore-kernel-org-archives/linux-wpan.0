Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:33940 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754799AbdA0Orh (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 27 Jan 2017 09:47:37 -0500
Received: by mail-qt0-f180.google.com with SMTP id w20so72321837qtb.1
        for <linux-wpan@vger.kernel.org>; Fri, 27 Jan 2017 06:47:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <23132.1485440790@obiwan.sandelman.ca>
References: <CAAK7Ti8d-1xHNg8T4P_AYCnUxp_akk4ge24tdqJoLMx-GxWrvw@mail.gmail.com>
 <23132.1485440790@obiwan.sandelman.ca>
From: JANARDHANACHARI KELLA <eni.chari@gmail.com>
Date: Fri, 27 Jan 2017 20:17:32 +0530
Message-ID: <CAAK7Ti_eZ1PxspnEF_mGEyXmmS4O2pw11U_yMVdMDAH0Rvemeg@mail.gmail.com>
Subject: Re: how to communicate with contiki node, from raspberry pi with
 at86rf233 module
Content-Type: text/plain; charset=UTF-8
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: linux-wpan@vger.kernel.org

Hi Michael,

Thank you for your replay..

On Thu, Jan 26, 2017 at 7:56 PM, Michael Richardson <mcr@sandelman.ca> wrote:
>
> JANARDHANACHARI KELLA <eni.chari@gmail.com> wrote:
>     > i have attached at86rf233 module to Raspberry pi. device is able to
>     > send radio packet data out. i am able to sniff from outside. any one
>     > please guide me, to initiate communication between contiki node and
>     > raspberry pi.
>
> Assuming that you have two contiki devices that can talk to each other so
> that we aren't debugging the contiki side of things:
>   Have you checked that you have the right PANIDs, and frequency choices?

yes, i had configured the same panid, and frequency.

> You also need to tell us something about the kernels involved

i am using 4.9 kernel which source i have taken from github/raspberrypi

>, the version of wpan-tools you are using,

the version of wpan-tools i am using is version 0.7

> how you are sniffing

i have taken a contiki node and i flashed sniffer program into it. and
i am using foren6 sniffing tool to capture the packets in air.

>, and how you are generating traffic.

i have been generated the traffic between raspberry
pi<--to-->raspberrypi and contiki node to contiki BR.

>
> --
> ]               Never tell me the odds!                 | ipv6 mesh networks [
> ]   Michael Richardson, Sandelman Software Works        | network architect  [
> ]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [
>

Thank you.

-- 
Sincerely Your's

Janardhanachari Kella
Contact:+91-9908469599
E-mail: eni.chari@gmail.com
