Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:53091
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751005AbdIKLZI (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Mon, 11 Sep 2017 07:25:08 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 975DDA0D51
        for <linux-wpan@vger.kernel.org>; Mon, 11 Sep 2017 11:25:36 +0000 (UTC)
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (s-opensource.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kJRy84y80t9S for <linux-wpan@vger.kernel.org>;
        Mon, 11 Sep 2017 11:25:36 +0000 (UTC)
Received: from [192.168.2.112] (pD9F79285.dip0.t-ipconnect.de [217.247.146.133])
        by osg.samsung.com (Postfix) with ESMTPSA id 80B18A0CAD
        for <linux-wpan@vger.kernel.org>; Mon, 11 Sep 2017 11:25:35 +0000 (UTC)
Subject: Re: [PATCH bluetooth-next 0/2] *** Firmware patch to support HULUSB
 ***
References: <20170901232822.31901-1-j.filzmaier@gmx.at>
From: Stefan Schmidt <stefan@osg.samsung.com>
Message-ID: <090edb81-8b3d-edb1-4078-d9a8bb41571c@osg.samsung.com>
Date: Mon, 11 Sep 2017 13:25:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170901232822.31901-1-j.filzmaier@gmx.at>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Hello.

On 09/02/2017 01:28 AM, Josef Filzmaier wrote:
> This patch (in combination with the linux kernel patch)
> introduces support for the Busware HUL stick. There are two
> commits, one that enables UART debugging (for convenience purposes)
> and another that modularizes the firmware to better support
> multiple hardware targets. As the Busware HUL stick uses the
> at86rf212 transceiver there have been a few modifications to
> support this transceiver. Otherwise this board is very similar to the
> already existing atusb and rzusb boards, meaning most of the code
> can be shared. (e.g. it also uses the at90usb1287 microcontroller).

I will wait for a last full review and testing until you sent out the 
updated version here with a bug fixed as you mentioned in your other mail.

regards
Stefan Schmidt
