Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84051A0731;
	Thu,  3 Apr 2025 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743669259; cv=none; b=jjoDkYcOWEYTH9zNYruSVpxCp2njBEGm+Bh6zmzqQUCjvuEKPnJdXw81A/yyrY2JUe+kVglOxeLtVBFHuNj9Aib6cCiqzhBE4x+HgxONrrOchiJ3Ipww/3jZB1mvXvyqLbtR2UX2jN+5PAgdF1gjWHZq8Zoid3a8C+yvg81SvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743669259; c=relaxed/simple;
	bh=wsQILO7hA49jzp8HRadJYXymQRE4ziUNrNRVayRBDFM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=twdKpq+wxPvVqsPr/ZutX1Fx66Ab+eN9pxb/7PX9pfODE68jzgu1kxbmD5uZ4NCq/7eIsKVXvPWFe3T5cVp7ooSgxT8BCl0iHL6awZLvxkPq96I9zibpZQtdZWDyxrdGqEw7Ba2ZVWL049ZeJfiqOQ7/8Z/1NKeLe7CBJk5ngUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UvRQap42; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UvRQap42"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D30DF4314D;
	Thu,  3 Apr 2025 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1743669248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsQILO7hA49jzp8HRadJYXymQRE4ziUNrNRVayRBDFM=;
	b=UvRQap427zmxaiWhYahVbFqmNWa61FRKhjZQkeZct7xnRE5tb0GbVKvIZHWZ9e18RdcLx0
	tEMtVvdMfZ98W7nAZT0sWmylth0yFpFOHnCDNn4fA6UfydGxyrQIlHzgYEjTqAJymqP/fL
	SlhA7NWn633IdcYY5pkofOuBwyjvjyt9wolYrxVw9IF8qxlGdje/PPHdpvk5RDNGyKlebv
	KpOqZElnQzBfcgDbPXoH2HxUl0ymxstZIJDGjrjjh6kGm7VGleUzUwBRC/xUb2kMx2DXIU
	qQssf2U3w+8chvvK9kP+7kzPDurS5YUG/to5QJ1vO1B+YNmvwyBEDAfUBrnWrQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Alexander Aring <alex.aring@gmail.com>,  Stefan Schmidt
 <stefan@datenfreihafen.org>,  "David S. Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,
  <linux-wpan@vger.kernel.org>,  <netdev@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net v2 0/3] Avoid calling WARN_ON() on allocation
 failure in cfg802154_switch_netns()
In-Reply-To: <20250403082021.990667-1-i.abramov@mt-integration.ru> (Ivan
	Abramov's message of "Thu, 3 Apr 2025 11:20:18 +0300")
References: <20250403082021.990667-1-i.abramov@mt-integration.ru>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 03 Apr 2025 10:34:06 +0200
Message-ID: <87plhtmyo1.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wpan@vger.kernel.org
List-Id: <linux-wpan.vger.kernel.org>
List-Subscribe: <mailto:linux-wpan+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wpan+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeektdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledvrddukeegrdduuddtrdduleelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledvrddukeegrdduuddtrdduleelpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehirdgrsghrrghmohhvsehmthdqihhnthgvghhrrghtihhonhdrrhhupdhrtghpthhtoheprghlvgigrdgrrhhinhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghfrghnsegurghtvghnfhhrvghihhgrfhgvnhdrohhrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrt
 ghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrgh
X-GND-Sasl: miquel.raynal@bootlin.com

On 03/04/2025 at 11:20:18 +03, Ivan Abramov <i.abramov@mt-integration.ru> w=
rote:

> This series was inspired by Syzkaller report on warning in
> cfg802154_switch_netns().

This series has received reviews under the form of Reviewed-by tags. You
are in charge of carrying those tags over versions. Please collect and
resubmit the series with all of them (a tag on the cover letter applies
to all patches).

Thanks,
Miqu=C3=A8l
