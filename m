Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:42473
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935421AbdAEMug (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Thu, 5 Jan 2017 07:50:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 3EC1EA13EA
        for <linux-wpan@vger.kernel.org>; Thu,  5 Jan 2017 12:49:42 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W6blGk5jnxgj for <linux-wpan@vger.kernel.org>;
        Thu,  5 Jan 2017 12:49:41 +0000 (UTC)
Received: from [192.168.2.110] (pD9F791C7.dip0.t-ipconnect.de [217.247.145.199])
        by osg.samsung.com (Postfix) with ESMTPSA id 693A7A13E9
        for <linux-wpan@vger.kernel.org>; Thu,  5 Jan 2017 12:49:41 +0000 (UTC)
Subject: Re: Requesting for process, to port driver from contiki to linux
References: <CAAK7Ti-pFkukD0wuRKKtg89oqeqAGycr--S1-ssdrXJwZsgT4Q@mail.gmail.com>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <c24f9bf0-97bf-ab26-1a5a-d147ae72d3c4@osg.samsung.com>
Date: Thu, 5 Jan 2017 13:49:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAAK7Ti-pFkukD0wuRKKtg89oqeqAGycr--S1-ssdrXJwZsgT4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 05/01/17 11:57, JANARDHANACHARI KELLA wrote:
> Hi,
>
> can any one explain how to port driver from contiki to linux?

Write a new one.

There is no process for this. Contiki and Linux are _very_ different in 
how they handle hardware. If you need to get a hardware support for 
Linux-wpan you best would be starting with one of the existing drivers 
as a reference and start adding the needed logic for yours.

What transceiver is it anyway, maybe there is already support for it or 
someones plans to work on it.

regards
Stefan Schmidt
