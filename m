Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from mailgw02.it.ntnu.no ([129.241.56.175]:50186 "EHLO
        mailgw02.it.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdKJM33 (ORCPT
        <rfc822;linux-wpan@vger.kernel.org>); Fri, 10 Nov 2017 07:29:29 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailgw02.it.ntnu.no (Postfix) with ESMTP id 7F85D802BBE
        for <linux-wpan@vger.kernel.org>; Fri, 10 Nov 2017 13:19:59 +0100 (CET)
Received: from mailgw02.it.ntnu.no ([127.0.0.1])
        by localhost (mailgw02.it.ntnu.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UR-HLDSLNG0C for <linux-wpan@vger.kernel.org>;
        Fri, 10 Nov 2017 13:19:59 +0100 (CET)
Received: from [10.69.0.10] (unknown [163.172.170.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: davidfp)
        by mailgw02.it.ntnu.no (Postfix) with ESMTPSA id EBF2A802BBF
        for <linux-wpan@vger.kernel.org>; Fri, 10 Nov 2017 13:19:58 +0100 (CET)
From: David Palma <david.palma@ntnu.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Bridging a lowpan interface
Message-Id: <1BB434E6-8E27-4282-84FE-4CC88C48ED68@ntnu.no>
Date: Fri, 10 Nov 2017 13:25:00 +0100
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan - ML <linux-wpan@vger.kernel.org>

Hi,

After shamefully trying it, I suppose it's not possible to add a lowpan interface to a bridge because it's not an ethernet segment.

However, I was wondering if this could/will be a possibility in the future?

If I understood correctly there was a discussion about the tun/tap driver that touched upon similar aspects, but I didn't get the conclusion.

The motivation for this question is to enable offloading/traffic redirection between 15.4 and .11 depending on certain conditions (e.g. energy and distance). I have accomplished this with changing routes and iptables but I was looking for an "SDN/OpenFlow-like" approach.

Thanks in advance,
--
David

