Return-Path: <linux-wpan-owner@vger.kernel.org>
Received: from sssup.it ([193.205.80.95]:55698 "EHLO sssup.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbbDHIyB (ORCPT <rfc822;linux-wpan@vger.kernel.org>);
	Wed, 8 Apr 2015 04:54:01 -0400
Received: from [10.30.2.209] (account m.petracca@sssup.it [10.30.2.209] verified)
  by sssup.it (CommuniGate Pro SMTP 5.3.15)
  with ESMTPSA id 100746727 for linux-wpan@vger.kernel.org; Wed, 08 Apr 2015 10:54:00 +0200
Message-ID: <5524ECA8.7000500@sssup.it>
Date: Wed, 08 Apr 2015 10:54:00 +0200
From: Matteo Petracca <matteo.petracca@sssup.it>
MIME-Version: 1.0
Subject: Raw ieee802154 socket
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-wpan.vger.kernel.org>
To: linux-wpan@vger.kernel.org

Dear all,
I want to create a raw ieee802154 socket, and I'm
following the test1.c example of lowpan-tools.

I succeeded in sending data packets, when I put in the buffer
a packet (header+payload) it is sent trough the channel as it
is (I checked with the sniffer). When I receive a data packet
I get in the buffer only the payload, without the header. Is there
any way to get back the header too?

I am using kernel 3.8.

Best,
Matteo
